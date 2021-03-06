#!/bin/bash

PLATFORM_NAME=zybo_z7_20
PETALINUX_PROJECT=Zybo-Z7-20
REPO_DIR=../../..

mkdir -p ../_platform/dsa
cp -f -v ${REPO_DIR}/vivado/${PLATFORM_NAME}/${PLATFORM_NAME}.dsa ../_platform/dsa/

cp -f -v ${REPO_DIR}/hw_handoff/${PLATFORM_NAME}_wrapper.hdf ./prebuilt/${PLATFORM_NAME}.hdf
cp -f -v ./prebuilt/${PLATFORM_NAME}.hdf ./prebuilt/${PLATFORM_NAME}.zip
mkdir ./tmp
unzip -o ./prebuilt/${PLATFORM_NAME}.zip -d ./tmp/
cp -f -v ./tmp/${PLATFORM_NAME}_wrapper.bit ./prebuilt/bitstream.bit
rm -f ./prebuilt/${PLATFORM_NAME}.zip
rm -rf ./tmp/ 

cp -f -v ${REPO_DIR}/sdk/hello_rt/src/lscript.ld ./freertos/lscript.ld
cp -f -v ${REPO_DIR}/linux/${PETALINUX_PROJECT}/images/linux/zynq_fsbl.elf ./freertos/boot/fsbl.elf
cp -f -v -r ${REPO_DIR}/sdk/hello_rt_bsp/ps7_cortexa9_0/include ./freertos/include

cp -f -v ${REPO_DIR}/sdk/hello_sa/src/lscript.ld ./standalone/lscript.ld
cp -f -v ${REPO_DIR}/linux/${PETALINUX_PROJECT}/images/linux/zynq_fsbl.elf ./standalone/boot/fsbl.elf

cp -f -v ${REPO_DIR}/linux/${PETALINUX_PROJECT}/images/linux/zynq_fsbl.elf ./linux/boot/fsbl.elf
cp -f -v ${REPO_DIR}/linux/${PETALINUX_PROJECT}/images/linux/u-boot.elf ./linux/boot/u-boot.elf
cp -f -v ${REPO_DIR}/linux/${PETALINUX_PROJECT}/images/linux/image.ub ./linux/image/image.ub

# Should consider adding sysroot even though it is not in Xilinx Platforms


