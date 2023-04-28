list=(
system/product/priv-app/com.huawei.appmarket/lib/arm64/libimagepipeline.so
system/product/priv-app/com.huawei.appmarket/lib/arm64/libfb.so
system/product/priv-app/com.huawei.appmarket/lib/arm64/libyoga.so
system/product/priv-app/com.huawei.appmarket/lib/arm64/libaegissec.so
system/product/priv-app/com.huawei.appmarket/lib/arm64/libgifimage.so
system/product/priv-app/com.huawei.appmarket/lib/arm64/libapppatch.so
system/product/priv-app/com.huawei.appmarket/lib/arm64/libscannative.so
system/product/priv-app/com.huawei.appmarket/lib/arm64/libnative-filters.so
system/product/priv-app/com.huawei.appmarket/lib/arm64/libnative-imagetranscoder.so
system/product/priv-app/com.huawei.appmarket/lib/arm64/libstatic-webp.so
system/product/priv-app/com.huawei.appmarket/lib/arm64/libapms_ndk_anr.so
system/product/priv-app/com.huawei.appmarket/lib/arm64/libhilog.so
system/product/priv-app/com.huawei.appmarket/lib/arm64/libjslite.so
system/product/priv-app/com.huawei.hwid/lib/arm64/libaegissec.so
system/product/priv-app/com.huawei.hwid/lib/arm64/libdex2oat-util.so
system/product/priv-app/com.huawei.appmarket/oat/arm64/base.odex
system/product/priv-app/com.huawei.appmarket/oat/arm64/base.vdex
system/product/priv-app/com.huawei.hwid/oat/arm64/base.odex
system/product/priv-app/com.huawei.hwid/oat/arm64/base.vdex
system/product/priv-app/com.huawei.appmarket/com.huawei.appmarket.apk
system/product/priv-app/com.huawei.hwid/com.huawei.hwid.apk
)

c_dir=$(pwd)
file=bin/files.txt

rm -f $file
cd ..

for ele in "${list[@]}"
do
	case $ele in
		*"com.huawei.appmarket"*)
			case $ele in
				*"lib/arm64"*)
					echo "${ele}:system/priv-app/com.huawei.appmarket/lib/arm64/$(basename $ele)" >> $file
					;;
				*"oat/arm64"*)
					echo "${ele}:system/priv-app/com.huawei.appmarket/oat/arm64/$(basename $ele)" >> $file
					;;
				*".apk")
					echo "${ele}:system/priv-app/com.huawei.appmarket/$(basename $ele)" >> $file
					;;
			esac
			;;
		*"com.huawei.hwid"*)
			case $ele in
				*"lib/arm64"*)
					echo "${ele}:system/app/com.huawei.hwid/lib/arm64/$(basename $ele)" >> $file
					;;
				*"oat/arm64"*)
					echo "${ele}:system/app/com.huawei.hwid/oat/arm64/$(basename $ele)" >> $file
					;;
				*".apk")
					echo "${ele}:system/app/com.huawei.hwid/$(basename $ele)" >> $file
					;;
			esac
			;;
	esac
done

cd $c_dir
