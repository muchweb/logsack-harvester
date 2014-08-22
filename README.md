# faggot

Stream Log Collector

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