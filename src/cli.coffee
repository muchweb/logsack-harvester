###*
	@module Logsack
	@author muchweb
###

'use strict'

program = require 'commander'
{Harvester} = require './harvester.js'
package_json = require '../package.json'

program
	.usage '[--in-stream] [--in-port 3000] [--out-file out.txt] [--out-stream]'
	.description 'run logsack stream log processor'
	.option '--in-stream', 'Use stdin as input'
	.option '--in-port [port]', 'Use input server on given port'
	.option '--out-file [filename]', 'Add output file'
	.option '--out-stream', 'Use stdout as output'
	.option '--out-port [address:port]', 'Use output server on given port'
	.version package_json.version
	.parse process.argv

# Display help if no options passed
# program.help() if process.argv.length is 2

harvester = new Harvester

if program.outStream?
	process.stdout.setEncoding 'utf8'
	harvester.AddOutputStream process.stdout

if program.outFile?
	harvester.AddOutputFile program.outFile

if program.outPort?
	harvester.AddOutputServer program.outPort

if program.inStream?
	process.stdin.setEncoding 'utf8'
	harvester.AddInputStream process.stdin

if program.inPort?
	harvester.AddInputServer program.inPort
