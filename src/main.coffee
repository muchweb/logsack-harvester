#!/usr/bin/env node

'use strict'

program = require 'commander'
Faggot = (require '../lib/faggot.js').Faggot
package_json = require '../package.json'

program
	.usage '[--in-stream] [--in-port 3000] [--out-file out.txt] [--out-stream]'
	.description 'run faggot stream log processor'
	.option '--in-stream', 'Use stdin as input'
	.option '--in-port [port]', 'Use input server on given port'
	.option '--out-file [filename]', 'Add output file'
	.option '--out-stream', 'Use stdout as output'
	.option '--out-port [address:port]', 'Use output server on given port'
	.version package_json.version
	.parse process.argv

faggot = new Faggot

if program.outStream?
	process.stdout.setEncoding 'utf8'
	faggot.AddOutputStream process.stdout

if program.outFile?
	faggot.AddOutputFile program.outFile

if program.outPort?
	faggot.AddOutputServer program.outPort

if program.inStream?
	process.stdin.setEncoding 'utf8'
	faggot.AddInputStream process.stdin

if program.inPort?
	faggot.AddInputServer program.inPort
