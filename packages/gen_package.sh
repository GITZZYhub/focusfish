#!/bin/bash

# 读取参数
packageName=$1         # flutter module的版本和所有的插件的版本保持一致

# 检查参数
if [ ! -n "${packageName}" ]
then
    echo "==packageName is null"
    exit
fi

flutter create --template=package $packageName