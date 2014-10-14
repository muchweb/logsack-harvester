faggot-io-core [![Build Status](https://travis-ci.org/faggot-io/faggot-io-core.svg)](https://travis-ci.org/faggot-io/faggot-io-core) [![NPM version](https://badge.fury.io/js/faggot-io-core.svg)](http://badge.fury.io/js/faggot-io-core) ![License: GPLv3+](http://img.shields.io/badge/license-GPLv3%2B-brightgreen.svg)
=================================================

## Server TCP Interface

Harvesters connect to the server via TCP, and write properly formatted strings to the socket.  Third party harvesters can send messages to the server using the following commands:

Register a new node

    +node|node\n

Remove a node with all streams

    -node|node\r\n

Register stream associations

    +stream|node|stream1,stream2\r\n

Remove stream associations

    -stream|node|stream1,stream2\r\n

Send a log message

    +log|node|name|timestamp|status|this is log message\n

## Building

There are no global dependencies

    npm install

## Testing

There are no gloabal NPM dependencies.

    npm test

### Compiling documentation

There are no gloabal NPM dependencies.

    npm run docs

Then navigate to `docs/index.html`. Documentation theme is based on [yuidoc-bootstrap-theme](https://www.npmjs.org/package/yuidoc-bootstrap-theme).

## Credits

Based on [NarrativeScience/Log.io](https://github.com/NarrativeScience/Log.io). For list of contributors, please see [AUTHORS](AUTHORS).

## :free: License

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.