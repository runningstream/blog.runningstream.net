#!/bin/bash

grep "http" *.md | grep -v "\(struts2.md\)\|\(malware-analysis.md\)\|\(struts2.md\)\|\(bold-claims-okane.md\)\|\(bitcoin-miner.md\)\|\(attack-movement.md\)"
