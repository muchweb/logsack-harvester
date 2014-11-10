# Logsack Harvester [![Build Status](https://travis-ci.org/muchweb/logsack-harvester.svg)](https://travis-ci.org/muchweb/logsack-harvester) [![NPM version](https://badge.fury.io/js/logsack-harvester.svg)](http://badge.fury.io/js/logsack-harvester) ![License: GPLv3+](http://img.shields.io/badge/license-GPLv3%2B-brightgreen.svg)

## :information_source: Achtung

> :warning: This version is under heavy development. If you are looking for  dramatically improved Log.io, please install it from this commit: [a2212d3ed36b7751c24469fbe3c6685bafb440a2](https://github.com/muchweb/logsack-harvester/tree/a2212d3ed36b7751c24469fbe3c6685bafb440a2) :wink:

## Installation

```bash
npm install -g logsack-harvester
```

## Usage:

```bash
  ls | logsack
```

Possible inputs:

 - [ ] stdin (default)
 - [ ] File
 - [ ] Network port (another harvester)

Possible outputs:

 - [ ] stdout (default)
 - [ ] File
 - [ ] Network port (another harvester)

## Example

1. Run input server
    `logsack --in-port 3000 --out-stream`

2. Run output server
    `echo "test" | logsack --in-stream --out-port localhost:3000`

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
