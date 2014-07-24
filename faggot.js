/*global module: true */
/*global require: true */

(function () {
	'use strict';

	var stream = require('stream'),
		util = require('util'),
		net = require('net');

	module.exports.Faggot = function (options) {
		stream.Duplex.call(this, options);

		if (typeof options === 'undefined')
			options = {};

		this.current_data = '';
		
		// Used for debugging
		this.counter = 0;
		
		this.StartServer();
	};

	util.inherits(module.exports.Faggot, stream.Duplex);

	module.exports.Faggot.prototype.StartServer = function () {
		
		// Start a TCP Server
		net.createServer(function (socket) {

			// Identify this client
			socket.name = socket.remoteAddress + ":" + socket.remotePort

			// Send a nice welcome message and announce
			console.log('Lumberjack has connected: ' + socket.name + '\n');
			
			// Handle incoming messages from clients.
			socket.on('data', function (data) {
				this.processLine(socket.name + ' > ' + data, socket);
			}.bind(this));

			// Remove the client from the list when it leaves
			socket.on('end', function () {
				console.log('Lumberjack has left: ' + socket.name + '\n');
			});

		}.bind(this)).listen(3000);
		console.log('Collector at 3000');
	}

	module.exports.Faggot.prototype._write = function (chunk) {
		var string = chunk.toString('utf8');

		this.current_data += string;

		var lines = this.current_data.split('\n');

		while (lines.length > 1)
			this.processLine(lines.shift());

		this.current_data = lines[0];
	};

	module.exports.Faggot.prototype._read = function () {};

	module.exports.Faggot.prototype.processLine = function (line) {
		
		// Outputting to stdout
		this.push(this.counter + line + '\n');
		this.counter++;
	}

}());