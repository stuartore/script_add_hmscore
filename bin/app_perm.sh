#!/bin/bash

my_script_dir=$(dirname ${BASH_SOURCE})
app_list=(
${my_script_dir}/../system/product/priv-app/com.huawei.appmarket/com.huawei.appmarket.apk
)

file=priv.xml
tg_file=${my_script_dir}/../configs/privapp-permission-appmarket.xml

if [[ "$(command -v aapt)" == "" ]];then
	if [[ "$(command -v apt)" != "" ]]; then
		sudo apt install aapt -y
	elif [[ "$(command -v pacman)" != "" ]]; then
		sudo pacman -Sy --no-confirm aapt
	elif [[ "$(command -v eopkg)" != "" ]]; then
		sudo eopkg it aapt
	fi
fi

echo '<?xml version="1.0" encoding="utf-8"?>' > $file
echo '<permissions>' >> $file

for app in "${app_list[@]}"
do
	app_pkg_name="$(aapt d permissions $app | grep 'package:' | sed 's|package: ||g')"
	app_perm_list=($(aapt d permissions ${app} | grep "'android.permission." | sed 's|uses-permission: name=||g' | sed "s/'//g"))
	echo "   <privapp-permissions package=\"$app_pkg_name\">" >> $file
	for app_perm in "${app_perm_list[@]}"
	do
		echo "    <permission name=\"$app_perm\" />" >> $file
	done
	echo '   </privapp-permissions>' >> $file
	echo >> $file
done

echo '</permissions>' >> $file

cat $file | grep -v 'SdkVersion' > $tg_file
rm -f $file
