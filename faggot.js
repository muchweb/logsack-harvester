/*global module: true */
/*global require: true */

(function () {
	'use strict';

	var stream = require('stream'),
		util = require('util');

	module.exports.Faggot = function (options) {
		stream.Duplex.call(this, options);

		if (typeof options === 'undefined')
			options = {};

		this.current_data = '';
	};

	util.inherits(module.exports.Faggot, stream.Duplex);

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
		console.log('Line', line);
	}

}());