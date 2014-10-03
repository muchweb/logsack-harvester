# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

'use strict'

stream = require 'stream'
util = require 'util'
net = require 'net'
fs = require 'fs'

###*
Main faggot class
@class Faggot
@param {[Object={}]} options object
###
module.exports.Faggot = class extends stream.Duplex
	constructor: (options = {}) ->
		stream.Duplex.call this, options
		@current_data = ''

		# Used for debugging
		@counter = 0
		@outputs = []

	###*
	!
	Add output to plain file
	@method AddOutputFile
	@param {filename} filename Target output file name
	###
	AddOutputFile: (filename) ->
		@AddOutputStream fs.createWriteStream(filename)

	###*
	!
	Add input from stream
	@method AddInputStream
	@param {Object} stream Output stream object
	###
	AddInputStream: (stream) ->
		stream.pipe this

	###*
	!
	Add output to stream
	@method AddOutputStream
	@param {Object} stream Input stream object
	###
	AddOutputStream: (stream) ->
		@outputs.push stream
		@pipe stream

	###*
	!
	Add input from port, start listening TCP server
	@method AddInputServer
	@param {[Number=3000]} port Port to listen to
	###
	AddInputServer: (port = 3000) ->
		# Identify this client
		# Send a nice welcome message and announce
		# Remove the client from the list when it leaves
		# Remove the client from the list when it leaves

		# Handle incoming messages from clients.
		net.createServer(((socket) ->
			socket.name = socket.remoteAddress + ':' + socket.remotePort
			console.log 'Lumberjack has connected: ' + socket.name
			socket.on 'end', ->
				console.log 'Lumberjack has left: ' + socket.name
				return

			socket.on 'end', ->
				console.log 'Lumberjack error: ' + socket.name
				return

			socket.pipe this
			return
		).bind(this)).listen port
		console.log 'Collector listening at port ' + port

	###*
	!
	Add output server (port). Logs will be sent to target host port
	@method AddOutputServer
	@param {[String='localhost:3000']} port Target host in 'host:port' format
	###
	AddOutputServer: (connection) ->
		connection = 'localhost:3000' if typeof connection is 'undefined'
		client = new net.Socket()
		connection_parts = connection.split(':')
		client.connect connection_parts[1], connection_parts[0], =>
			console.log 'Connected to: ' + connection
			@pipe client

	_write: (chunk, a, b) ->
		string = chunk.toString('utf8')
		@current_data += string
		lines = @current_data.split('\n')
		@processLine lines.shift() while lines.length > 1
		@current_data = lines[0]

	_read: ->
		# Left blank intentionally

	end: ->
		console.log 'Input ended'


	# module.exports.Faggot.prototype.onend = function () {
	# 	console.log('onend');
	# };
	# module.exports.Faggot.prototype.unpipe = function () {
	# 	console.log('unpipe');
	# };
	# module.exports.Faggot.prototype.end = function () {
	# 	this.push(null);
	# };
	processLine: (line) ->

		# Outputting to stdout
		@push '#' + @counter + ':\t' + line
		@counter++

