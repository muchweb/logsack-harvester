'use strict'

fs = require 'fs'
events = require 'events'

###*
# Mainly used by `LogHarvester`.
#
#  - Watches log file for changes
#  - Extracts new log messages
#  - Then emits 'log_new' events.
#
# @class FileWatcher
# @extends events.EventEmitter
###
exports.FileWatcher = class extends events.EventEmitter

	###*
	# Emits event for every new captured log line
	# @event log_new
	# @param {String} message Log line
	###

	###*
	# Started watching a file
	# @event file_watching
	# @param {String} path Target filename
	# @param {Boolean} watching If file watch was started successfully on not
	###

	###*
	# Initializing new `FileWatcher` instance
	# @constructor
	# @param {Object} name name of current log stream. Only used for debugging.
	# @param {Object} paths Array of local files paths.
	# @param {Object} log Winston (or compatible) logger object. Only used for debugging.
	###
	constructor: (@name, @paths, @log) ->
		@watchers = {}
		@keep_retrying = true

	###*
	# Initialising all file watching
	# @method Watch
	###
	Watch: ->
		@log.info "Starting log stream: '#{@name}'"
		@WatchFile path for path in @paths
		@

	###*
	# Stopping all file watching
	# @method UnWatch
	###
	UnWatch: ->
		@keep_retrying = false
		for path, watcher of @watchers
			@log.info 'Unwatching file', path
			watcher.close()
		@

	###*
	# Watching all files under specified directory
	# @method watch
	# @param {String} path Path to directory
	###
	WatchDirectory: (path) ->
		for k, i of fs.readdirSync path
			@WatchFile path + "/" + i

	###*
	# Starting to watch file changes.
	# @method watch
	# @param {String} path Path to file or a directory
	###
	WatchFile: (path) ->
			# Checking if file exists
			if not fs.existsSync path
				@emit 'file_watching', path, false
				if @keep_retrying
					@log.error "File doesn't exist: '#{path}'. Retrying in 1000ms."
					setTimeout (=> @WatchFile path), 1000
				return

			# Checking if path is a directory
			if fs.lstatSync(path).isDirectory()
				@WatchDirectory(path);
				return

			@log.info "Watching file: '#{path}'"
			@emit 'file_watching', path, true
			currSize = fs.statSync(path).size

			if @watchers[path]
				@watchers[path].close()
				delete @watchers[path]

			watcher = fs.watch path, (event, filename) =>

				if event is 'rename'
					# File has been rotated, start new watcher
					@WatchFile path

				if event is 'change'
					# Capture file offset information for change event
					fs.exists path, (exists) =>
						if exists
							fs.stat path, (err, stat) =>
								@ReadNewLogs path, stat.size, currSize
								currSize = stat.size
						else
							@WatchFile path

			@watchers[path] = watcher

	###*
	# File change has been detected. Determining what has been changed and emitting `log_new` event.
	# @method watch
	# @param {String} path Path to file or a directory
	###
	ReadNewLogs: (path, curr, prev) ->
		# Use file offset information to stream new log lines from file
		return if curr < prev
		rstream = fs.createReadStream path,
			encoding: 'utf8'
			start: prev
			end: curr

		rstream.on 'data', (data) =>
			lines = data.split "\n"
			@emit 'log_new', line for line in lines when line

		rstream.on 'error', (data) =>

		rstream.on 'end', (data) =>