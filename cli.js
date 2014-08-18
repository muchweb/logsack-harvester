#!/usr/bin/env node

/*global require: true */

(function () {
	'use strict';

	var program = require('commander'),
		Faggot = require('./faggot.js').Faggot,
		package_json = require('./package.json'),
		faggot;

	program
		.usage('')
		.version(package_json.version)
		.parse(process.argv);

	process.stdin.setEncoding('utf8');

	faggot = new Faggot();
	faggot.AddOutputStream(process.stdout);
	faggot.AddOutputFile('faggot_out0.txt');
	faggot.AddOutputFile('faggot_out1.txt');
	faggot.AddInputStream(process.stdin);

}());