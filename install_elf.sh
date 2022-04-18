#!/bin/bash

source config_specfic_elf.sh $@

echo "Installing on internal flash..."

ELF_FILE=$3
if [ ! -f ${ELF_FILE} ];then
	echo "File ${ELF_FILE} not found."
	exit 1
fi

echo "Flashing ${ELF_FILE} ..."

#exit 0

if ! ${OPENOCD} -f openocd/interface_"${ADAPTER}".cfg \
    -c "init;" \
    -c "halt;" \
    -c "program ${ELF_FILE};" \
    -c "program prebuilt/gw_retrogo_nes_extflash.bin 0x90000000"
    -c "exit;" >>logs/5_openocd.log 2>&1; then
    echo "Installing on flash failed."
    exit 1
fi


echo "Success!"
