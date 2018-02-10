#!/bin/bash

PV_PATH_SRC=$1
PV_PATH_DST=$2

LINES='"libvirt rhel72"'

for LINE in $LINES;
do
read ITYPE SRC <<<$LINE
  virt-v2v -i "$ITYPE" "$SRC" -o local -oa sparse -of raw -os .
  # generate disk and domxml

  xsltproc toVMSpec.xsl *.xml
done
