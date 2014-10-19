#!/usr/bin/env node

/*global require: true */

(function () {
	'use strict';

	var program = require('commander'),
		Faggot = require('./lib/faggot.js').Faggot,
		package_json = require('./package.json'),
		faggot;

	program
		.usage('[--in-stream] [--in-port 3000] [--out-file out.txt] [--out-stream]')
		.description('run faggot stream log processor')
		.option('--in-stream', 'Use stdin as input')
		.option('--in-port [port]', 'Use input server on given port')
		.option('--out-file [filename]', 'Add output file')
		.option('--out-stream', 'Use stdout as output')
		.option('--out-port [address:port]', 'Use output server on given port')
		.version(package_json.version)
		.parse(process.argv);

	faggot = new Faggot();

	if (typeof program.outStream !== 'undefined') {
		process.stdout.setEncoding('utf8');
		faggot.AddOutputStream(process.stdout);
	}

	if (typeof program.outFile !== 'undefined')
		faggot.AddOutputFile(program.outFile);

	if (typeof program.outPort !== 'undefined')
		faggot.AddOutputServer(program.outPort);

	if (typeof program.inStream !== 'undefined') {
		process.stdin.setEncoding('utf8');
		faggot.AddInputStream(process.stdin);
	}

	if (typeof program.inPort !== 'undefined')
		faggot.AddInputServer(program.inPort);

}());