#!/bin/sh

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

$DIR/djinni/src/run \
    --objc-out $DIR/Machine\ Obj-C++ \
    --cpp-out $DIR/Machine\ C++ \
    --idl $DIR/image_cache.djinni
