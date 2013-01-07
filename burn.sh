#!/bin/sh

ADEPT_DIR=/opt/digilent.adept.utilities_2.1.1-x86_64
DJTGCFG=$ADEPT_DIR/bin64/djtgcfg

$DJTGCFG prog -d Cr2s2 -i 0 -f main.jed
