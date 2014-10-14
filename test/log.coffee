Log = (require '..').Log
os = require 'os'
path = require 'path'

exports.Constructing =
	'default host': (test) ->
		item = new Log
		test.strictEqual item.host, os.hostname()
		test.done()

	'default name': (test) ->
		item = new Log
		test.strictEqual item.name, 'faggot-io-core'
		test.done()

	'default time': (test) ->
		item = new Log
		test.ok (item.time - Date.now()) < 50
		test.done()

	'default status': (test) ->
		item = new Log
		test.strictEqual item.status, null
		test.done()

	'default is_text': (test) ->
		item = new Log
		test.strictEqual item.is_text, false
		test.done()

	'default text': (test) ->
		item = new Log
		test.strictEqual item.text, null
		test.done()

	'overridden host': (test) ->
		item = new Log
			host: 'testing'
		test.strictEqual item.host, 'testing'
		test.done()

	'overridden name': (test) ->
		item = new Log
			name: 'testing'
		test.strictEqual item.name, 'testing'
		test.done()

	'overridden time': (test) ->
		item = new Log
			time: 123456789
		test.strictEqual item.time, 123456789
		test.done()

	'overridden status': (test) ->
		item = new Log
			status: 'error'
		test.strictEqual item.status, 'error'
		test.done()

	'overridden is_text': (test) ->
		item = new Log
			is_text: true
		test.strictEqual item.is_text, true
		test.done()

	'overridden text': (test) ->
		item = new Log
			text: 'testing'
		test.strictEqual item.text, 'testing'
		test.done()

	'custom property': (test) ->
		item = new Log
			testing: 'testing'
		test.strictEqual item.testing, 'testing'
		test.done()

	'undefined property': (test) ->
		item = new Log
		test.strictEqual typeof item.testing, 'undefined'
		test.done()

exports.SetText =
	'adding text via constructor': (test) ->
		item = new Log
			text: 'testing'
		test.strictEqual item.text, 'testing'
		test.strictEqual item.is_text, true
		test.done()

	'adding text via function': (test) ->
		item = new Log
		item.SetText 'testing'
		test.strictEqual item.text, 'testing'
		test.strictEqual item.is_text, true
		test.done()

exports.GetData =
	'default': (test) ->
		item = new Log
		test.deepEqual item.GetData(), []
		test.done()

	'text log': (test) ->
		item = new Log
			text: 'testing'
		test.deepEqual item.GetData(), [
			'log'
			os.hostname()
			'faggot-io-core'
			'testing'
		]
		test.done()

exports.toString =
	'default': (test) ->
		item = new Log
		test.strictEqual String(item), ''
		test.done()

	'text log': (test) ->
		item = new Log
			text: 'testing'
		test.strictEqual String(item), "log|#{os.hostname()}|faggot-io-core|testing"
		test.done()