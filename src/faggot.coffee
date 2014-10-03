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
	constructor: (options) ->
		stream.Duplex.call this, options
		options = {}	if typeof options is "undefined"
		@current_data = ""

		# Used for debugging
		@counter = 0
		@outputs = []
		return

	###*
	!
	Add output to plain file
	@method AddOutputFile
	@param {filename} filename Target output file name
	###
	AddOutputFile: (filename) ->
		@AddOutputStream fs.createWriteStream(filename)
		return

	###*
	!
	Add input from stream
	@method AddInputStream
	@param {Object} stream Output stream object
	###
	AddInputStream: (stream) ->
		stream.pipe this
		return


	###*
	!
	Add output to stream
	@method AddOutputStream
	@param {Object} stream Input stream object
	###
	AddOutputStream: (stream) ->
		@outputs.push stream
		@pipe stream
		return


	###*
	!
	Add input from port, start listening TCP server
	@method AddInputServer
	@param {[Number=3000]} port Port to listen to
	###
	AddInputServer: (port) ->
		port = 3000	if typeof port is "undefined"

		# Identify this client

		# Send a nice welcome message and announce

		# Remove the client from the list when it leaves

		# Remove the client from the list when it leaves

		# Handle incoming messages from clients.
		net.createServer(((socket) ->
			socket.name = socket.remoteAddress + ":" + socket.remotePort
			console.log "Lumberjack has connected: " + socket.name
			socket.on "end", ->
				console.log "Lumberjack has left: " + socket.name
				return

			socket.on "end", ->
				console.log "Lumberjack error: " + socket.name
				return

			socket.pipe this
			return
		).bind(this)).listen port
		console.log "Collector listening at port " + port
		return


	###*
	!
	Add output server (port). Logs will be sent to target host port
	@method AddOutputServer
	@param {[String='localhost:3000']} port Target host in 'host:port' format
	###
	AddOutputServer: (connection) ->
		connection = "localhost:3000"	if typeof connection is "undefined"
		client = new net.Socket()
		connection_parts = connection.split(":")
		client.connect connection_parts[1], connection_parts[0], (->
			console.log "Connected to: " + connection
			@pipe client
			return
		).bind(this)
		return

	_write: (chunk, a, b) ->
		string = chunk.toString("utf8")
		@current_data += string
		lines = @current_data.split("\n")
		@processLine lines.shift()	while lines.length > 1
		@current_data = lines[0]
		return

	_read: ->

	end: ->
		console.log "Input ended"
		return


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
		@push "#" + @counter + ":\t" + line
		@counter++
		return