'use strict'

os = require 'os'
path = require 'path'

###*
# @class Log
# @extends events.EventEmitter
###
exports.Log = class

	@glue: '|'

	node: null
	name: null
	time: null
	status: null

	is_text: false
	text: null

	constructor: (options = {}) ->
		@time = Date.now()
		@node = os.hostname()
		@name = process
			.cwd()
			.split path.sep
			.pop()

		# Apply all options
		@[key] = val for key, val of options

		@SetText options.text if options.text?

	SetStatusFromText: (@status) ->
		text_exploded = @text.split exports.Log.glue
		@status = null
		@status = text_exploded.shift() if text_exploded.length > 0

	SetText: (@text='') ->
		@text = @text.join exports.Log.glue if typeof @text is 'object'
		@SetStatusFromText()
		@is_text = @text isnt ''

	GetData: ->
		if @is_text
			data = []
			data.push 'log'
			data.push @time
			data.push @node
			data.push @name
			data = data.concat @text.split exports.Log.glue if @text isnt ''
			return data
		return []

	toString: ->
		return @GetData().join exports.Log.glue