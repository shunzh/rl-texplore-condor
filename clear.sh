#!/bin/sh

cd $1
rm err.* out.* condor.log experiences.bin
./get.sh
cd ..
