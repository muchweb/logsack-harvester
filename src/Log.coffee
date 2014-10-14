'use strict'

os = require 'os'
path = require 'path'

###*
# @class Log
# @extends events.EventEmitter
###
exports.Log = class

	@glue: '|'
	@lister: ','

	node: null
	stream: null
	time: null
	status: null

	is_text: false
	text: null

	constructor: (options = {}) ->
		@time = Date.now()
		@node = os.hostname()
		@stream = process
			.cwd()
			.split path.sep
			.pop()

		# Apply all options
		@[key] = val for key, val of options

		@SetText options.text if options.text?
		@SetStream options.stream if options.stream?

	SetStatusFromText: (@status) ->
		text_exploded = @text.split exports.Log.glue
		@status = null
		@status = text_exploded.shift() if text_exploded.length > 0

	SetStream: (@stream='') ->
		@stream = @stream.join exports.Log.lister if typeof @stream is 'object'

	SetText: (@text='') ->
		@text = @text.join exports.Log.glue if typeof @text is 'object'
		@SetStatusFromText()
		@is_text = @text isnt ''

	GetData: ->
		if @is_text
			data = []
			data.push '+log'
			data.push @time
			data.push @node
			data.push @stream
			data = data.concat @text.split exports.Log.glue if @text isnt ''
			return data
		return []

	toString: ->
		return @GetData().join exports.Log.glue