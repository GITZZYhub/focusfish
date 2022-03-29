#!/bin/bash

# 读取参数
pluginName=$1         # flutter module的版本和所有的插件的版本保持一致

# 检查参数
if [ ! -n "${pluginName}" ]
then
    echo "==pluginName is null"
    exit
fi

flutter create --org com.bwjh --template=plugin --platforms=android,ios -i swift -a kotlin $pluginName