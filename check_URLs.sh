#!/bin/bash

EXCEPTIONS="struts2.md malware-analysis.md bold-claims-okane.md bitcoin-miner.md attack-movement.md disinvited-by-user-agent-windows.md old-netgear-dgn-bug.md adb-shells.md cgi-bin-php-clean.md just-try-a-put-miner.md"

EXC_CMD='print("\\("+"\\)\\|\\(".join("'$EXCEPTIONS'".split())+"\\)")'
BUILD_LIST=$(python3 -c "$EXC_CMD")

OUTPUT=`grep "http" content/post/*.md | grep -v "$BUILD_LIST"`

if [ "$OUTPUT" != "" ]; then
    echo "$OUTPUT"
    exit 1
else
    exit 0
fi
