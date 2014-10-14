faggot-io-core - Real-time log monitoring in your browser [![Build Status](https://travis-ci.org/faggot-io/faggot-io.svg?branch=master)](https://travis-ci.org/faggot-io/faggot-io)
=================================================

## Server TCP Interface

Harvesters connect to the server via TCP, and write properly formatted strings to the socket.  Third party harvesters can send messages to the server using the following commands:

Send a log message

    +log|host|name|time|status|this is log message\r\n

Register a new node

    +node|my_node\r\n

Register a new node, with stream associations

    +node|my_node|my_stream1,my_stream2\r\n

Remove a node

    -node|my_node\r\n


## Building

Global NPM dependencies: `coffee-script`, `mocha`, `less` and `browserify`

    npm install
    cake build

### Building documentation

Global NPM dependency: `yuidocjs`

    cake docs

Then navigate to `docs/index.html`

Theme was based on [yuidoc-bootstrap-theme](https://www.npmjs.org/package/yuidoc-bootstrap-theme).

## Testing

Global NPM dependencies: `nodeunit`

    npm test

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