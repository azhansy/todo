#! /bin/bash
#打包构建内网包【执行前确保分支代码为最新】

currentPath=$(pwd)
echo "$currentPath"

flutter build apk

sleep 2s

#移动目录
mv "$currentPath/build/app/outputs/flutter-apk/app-release.apk" "$currentPath/release/"

echo "==============End to Build==============="