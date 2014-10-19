faggot-io-core [![Build Status](https://travis-ci.org/faggot-io/faggot-io-core.svg)](https://travis-ci.org/faggot-io/faggot-io-core) [![NPM version](https://badge.fury.io/js/faggot-io-core.svg)](http://badge.fury.io/js/faggot-io-core) ![License: GPLv3+](http://img.shields.io/badge/license-GPLv3%2B-brightgreen.svg)
=================================================

## Installation

```bash
npm install --save git+https://github.com/faggot-io/faggot-io-harvester.git
```

## Usage:

```bash
  ls | faggot
```

Possible inputs:
- stdin (default)
- File
- Port

Possible output:
- strout (default)
- File
- Port

## Example

1. Run input server
    `faggot --in-port 3000 --out-stream`

2. Run output server
    `echo "test" | faggot --in-stream --out-port localhost:3000`

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