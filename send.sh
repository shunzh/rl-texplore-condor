#!/bin/sh

cd $1
condor_submit ros.condor
cd ..
