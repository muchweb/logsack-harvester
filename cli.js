#!/usr/bin/env node

/*global require: true */
/*global process: true */

(function () {
	'use strict';

	var program = require('commander'),
		Faggot = require('./faggot.js').Faggot,
		package_json = require('./package.json');

	program
		.usage('')
		.version(package_json.version)
		.parse(process.argv);

	process.stdin
		.pipe(new Faggot())
		.pipe(process.stdout);

}());