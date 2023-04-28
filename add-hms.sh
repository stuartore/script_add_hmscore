#1/bin/bash

script_dir=$(dirname ${BASH_SOURCE})
c_dir=$(pwd)

system_img_path=$1
sgsi_path=$(dirname $system_img_path)
perm_file=${sgsi_path}/out/system/system/etc/permissions/privapp-permissions-platform.xml

if [[ ! -f ${sgsi_path}/system.img ]];then
	echo "=> system image not found in SGSI-BUILD-TOOL"
	exit 1
fi

if [[ ! -d ${sgsi_path}/out/system/system ]];then
	# try to use it
	cd ${sgsi_path}
	echo system | sudo ./unpackimg.sh
fi

# add props
if [[ ! $(sudo grep 'ro.product.manufacturer=HUAWEI' ${sgsi_path}/out/system/system/build.prop) ]];then
	sudo sed -i '/system.prop/a \
ro.product.manufacturer=HUAWEI \
ro.product.brand=HUAWEI \
ro.product.model=BAL-AL00 \
ro.product.name=BAL-AL00 \
ro.product.device=BAL-AL00' ${sgsi_path}/out/system/system/build.prop
fi

# copy libs
sudo cp -rf ${script_dir}/system/lib/* ${sgsi_path}/out/system/system/lib/
sudo cp -rf ${script_dir}/system/lib64/* ${sgsi_path}/out/system/system/lib64/

# copy apks
sudo cp -rf ${script_dir}/system/product/priv-app/com.huawei.appmarket ${sgsi_path}/out/system/system/priv-app
sudo cp -rf ${script_dir}/system/product/priv-app/com.huawei.hwid ${sgsi_path}/out/system/system/app

if [[ ! $(sudo grep 'com.huawei.appmarket' ${sgsi_path}/out/config/*) ]];then
	sudo sh -c "cat ${script_dir}/configs/system_file_contexts >> ${sgsi_path}/out/config/system_file_contexts"
	sudo sh -c "cat ${script_dir}/configs/system_fs_config >> ${sgsi_path}/out/config/system_fs_config"
fi

# add priv app permission
if [[ ! $(grep 'package="com.huawei.appmarket"' $perm_file) ]];then
	sudo chmod +x ${script_dir}/bin/app_perm.sh
	sudo bash ${script_dir}/bin/app_perm.sh

	tmp_permission_file=${script_dir}/configs/perm-tmp.xml
	cp -f ${script_dir}/configs/privapp-permission-appmarket.xml $tmp_permission_file
	sed -i '/<?xml version="1.0" encoding="utf-8"?>/d' $tmp_permission_file
	sed -i '/<permissions>/d' $tmp_permission_file
	sed -i '/<\/permissions>/d' $tmp_permission_file
	sudo sed -i '/<\/permissions>/d' $perm_file
	sudo sh -c "cat $tmp_permission_file >> $perm_file"
	sudo sh -c "echo '</permissions>' >> $perm_file"
	rm -f $tmp_permission_file
fi

if [[ $? -eq 0 ]];then
	cd $c_dir
	echo -e "\n=> 已添加HMSCore到系统 \033[2m- 提示[ sudo ./makeimg2.sh ]\033[0m"
fi
