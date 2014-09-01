/*global module: true */
/*global require: true */
/*global process: true */

(function () {
	'use strict';

	var stream = require('stream'),
		util = require('util'),
		net = require('net'),
		fs = require('fs');

	/**!
	 Main faggot class
	 @class Faggot
	 @param {[Object={}]} options object
	**/
	module.exports.Faggot = function (options) {
		stream.Duplex.call(this, options);

		if (typeof options === 'undefined')
			options = {};

		this.current_data = '';

		// Used for debugging
		this.counter = 0;

		this.outputs = [];
	};

	util.inherits(module.exports.Faggot, stream.Duplex);

	/**!
	 Add output to plain file
	 @method AddOutputFile
	 @param {filename} filename Target output file name
	**/
	module.exports.Faggot.prototype.AddOutputFile = function (filename) {
		this.AddOutputStream(fs.createWriteStream(filename));
	};

	/**!
	 Add input from stream
	 @method AddInputStream
	 @param {Object} stream Output stream object
	**/
	module.exports.Faggot.prototype.AddInputStream = function (stream) {
		stream.pipe(this);
	};

	/**!
	 Add output to stream
	 @method AddOutputStream
	 @param {Object} stream Input stream object
	**/
	module.exports.Faggot.prototype.AddOutputStream = function (stream) {
		this.outputs.push(stream);
		this.pipe(stream);
	};

	/**!
	 Add input from port, start listening TCP server
	 @method AddInputServer
	 @param {[Number=3000]} port Port to listen to
	**/
	module.exports.Faggot.prototype.AddInputServer = function (port) {
		if (typeof port === 'undefined')
			port = 3000;

		net.createServer(function (socket) {

			// Identify this client
			socket.name = socket.remoteAddress + ":" + socket.remotePort

			// Send a nice welcome message and announce
			console.log('Lumberjack has connected: ' + socket.name);

			// Remove the client from the list when it leaves
			socket.on('end', function () {
				console.log('Lumberjack has left: ' + socket.name);
			});

			// Remove the client from the list when it leaves
			socket.on('end', function () {
				console.log('Lumberjack error: ' + socket.name);
			});

			// Handle incoming messages from clients.
			socket.pipe(this);

		}.bind(this)).listen(port);
		console.log('Collector listening at port ' + port);
	};

	/**!
		Add output server (port). Logs will be sent to target host port
		@method AddOutputServer
		@param {[String='localhost:3000']} port Target host in 'host:port' format
	**/
	module.exports.Faggot.prototype.AddOutputServer = function (connection) {
		if (typeof connection === 'undefined')
			connection = 'localhost:3000';

		var client = new net.Socket(),
			connection_parts = connection.split(':');

		client.connect(connection_parts[1], connection_parts[0], function() {
		 console.log('Connected to: ' + connection);

		 	this.pipe(client);
		}.bind(this));
	};

	module.exports.Faggot.prototype._write = function (chunk, a, b) {
		var string = chunk.toString('utf8');

		this.current_data += string;

		var lines = this.current_data.split('\n');

		while (lines.length > 1)
			this.processLine(lines.shift());

		this.current_data = lines[0];
	};

	module.exports.Faggot.prototype._read = function () {

	};

	module.exports.Faggot.prototype.end = function () {
		console.log('Input ended');
	};

	// module.exports.Faggot.prototype.onend = function () {
	// 	console.log('onend');
	// };
	// module.exports.Faggot.prototype.unpipe = function () {
	// 	console.log('unpipe');
	// };
	// module.exports.Faggot.prototype.end = function () {
	// 	this.push(null);
	// };


	module.exports.Faggot.prototype.processLine = function (line) {

		// Outputting to stdout
		this.push('#' + this.counter + ':\t' + line);
		this.counter++;
	}

}());