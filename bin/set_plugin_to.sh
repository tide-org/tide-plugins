#!/bin/bash

echo "This script needs to be dot sourced"
echo
echo "Selected config is: $1"
echo "PWD is $PWD"
FULL_PATH="$PWD/$1"
echo "Plugin path is: $FULL_PATH"
echo "export TIDE_CONFIG_LOCATION=$FULL_PATH"
export TIDE_CONFIG_LOCATION=$FULL_PATH
