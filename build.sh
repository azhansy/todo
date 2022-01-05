#! /bin/bash
#打包构建内网包【执行前确保分支代码为最新】

currentPath=$(pwd)
echo "$currentPath"

#build居然出现在Android目录下
rm -rf "$currentPath"/android/app/build

flutter clean

echo "==============Build app ==============="

flutter build apk --release  #--obfuscate --split-debug-info=./build/symbols（object not found for DQa）

sleep 2s

#移动目录
mv "$currentPath"/build/app/outputs/apk/release/*.apk "$currentPath"/release/
mv "$currentPath"/android/app/build/outputs/apk/release/*.apk "$currentPath"/release/

echo "==============Build app End ==============="

echo "==============Build web ==============="

flutter build web

sleep 2s

mv "$currentPath"/build/web "$currentPath"/release/

echo "==============Build web End==============="

echo "==============End to Build==============="
