'use strict'

os = require 'os'
path = require 'path'

###*
# @class Log
# @extends events.EventEmitter
###
exports.Log = class

	host: null
	name: null
	time: null

	status: null

	is_text: false
	text: null

	constructor: (options = {}) ->
		@time = Date.now()
		@host = os.hostname()
		@name = process
			.cwd()
			.split path.sep
			.pop()

		# Apply all options
		@[key] = val for key, val of options

		@SetText options.text if options.text?

	SetText: (@text='') ->
		@is_text = @text isnt ''

	GetData: ->
		if @is_text
			return [
				'log'
				@host
				@name
				@text
			]
		return []

	toString: ->
		return @GetData().join '|'