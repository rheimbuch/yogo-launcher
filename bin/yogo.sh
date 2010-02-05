#!/bin/bash

BIN=`dirname $0`
VENDOR="$BIN/../vendor"
JRUBY="java -jar $VENDOR/jruby-complete-1.4.0.jar"
$JRUBY bin/yogo $@