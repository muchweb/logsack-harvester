Log = (require '..').Log
os = require 'os'
path = require 'path'

exports.Constructing =
	'default node': (test) ->
		item = new Log
		test.strictEqual item.node, os.hostname()
		test.done()

	'default stream': (test) ->
		item = new Log
		test.strictEqual item.stream, 'faggot-io-core'
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

	'overridden node': (test) ->
		item = new Log
			node: 'testing'
		test.strictEqual item.node, 'testing'
		test.done()

	'overridden stream': (test) ->
		item = new Log
			stream: 'testing'
		test.strictEqual item.stream, 'testing'
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

exports.SetStream =
	'adding stream via constructor - string': (test) ->
		item = new Log
			stream: 'testing'
		test.strictEqual item.stream, 'testing'
		test.done()

	'adding stream via constructor - array': (test) ->
		item = new Log
			stream: [
				'testing1'
				'testing2'
			]
		test.strictEqual item.stream, 'testing1,testing2'
		test.done()

	'adding stream via function - string': (test) ->
		item = new Log
		item.SetStream 'testing'
		test.strictEqual item.stream, 'testing'
		test.done()

	'adding stream via function - array': (test) ->
		item = new Log
		item.SetStream [
			'testing1'
			'testing2'
		]
		test.strictEqual item.stream, 'testing1,testing2'
		test.done()


exports.SetText =
	'adding text via constructor - string': (test) ->
		item = new Log
			text: 'testing'
		test.strictEqual item.text, 'testing'
		test.strictEqual item.is_text, true
		test.done()

	'adding text via function - string': (test) ->
		item = new Log
		item.SetText 'testing'
		test.strictEqual item.text, 'testing'
		test.strictEqual item.is_text, true
		test.done()

	'adding text via constructor - array': (test) ->
		item = new Log
			text: [
				'testing1'
				'testing2'
			]
		test.strictEqual item.text, 'testing1|testing2'
		test.strictEqual item.is_text, true
		test.done()

	'adding text via function - array': (test) ->
		item = new Log
		item.SetText [
			'testing1'
			'testing2'
		]
		test.strictEqual item.text, 'testing1|testing2'
		test.strictEqual item.is_text, true
		test.done()

exports.SetStatusFromText =
	'same as text': (test) ->
		item = new Log
			text: 'testing'
		test.strictEqual item.text, 'testing'
		test.strictEqual item.status, 'testing'
		test.done()

	'from string': (test) ->
		item = new Log
			text: 'info|testing'
		test.strictEqual item.text, 'info|testing'
		test.strictEqual item.status, 'info'
		test.done()

	'from array': (test) ->
		item = new Log
			text: [
				'info'
				'testing'
			]
		test.strictEqual item.text, 'info|testing'
		test.strictEqual item.status, 'info'
		test.done()

exports.GetData =
	'default': (test) ->
		item = new Log
		test.deepEqual item.GetData(), []
		test.done()

	'text log': (test) ->
		item = new Log
			text: 'testing'
			time: 12345678

		test.deepEqual item.GetData(), [
			'+log'
			12345678
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
			time: 12345678

		test.strictEqual String(item), "+log|12345678|#{os.hostname()}|faggot-io-core|testing"
		test.done()