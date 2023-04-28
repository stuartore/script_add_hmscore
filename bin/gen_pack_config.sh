lib_files=(
libaegissec
libapms_ndk_anr
libapppatch
libdex2oat-util
libfb
libgifimage
libhilog
libimagepipeline
libjslite
libnative-filters
libnative-imagetranscoder
libnllvm-base
libscannative
libstatic-webp
libyoga
)

apk_files=(
system/priv-app/com.huawei.appmarket/com.huawei.appmarket.apk
system/app/com.huawei.hwid/com.huawei.hwid.apk
)

market_lib_files=(
libaegissec
libapms_ndk_anr
libapppatch
libfb
libgifimage
libhilog
libimagepipeline
libjslite
libnative-filters
libnative-imagetranscoder
libscannative
libstatic-webp
libyoga
)

hms_lib_files=(
libaegissec
libdex2oat-util
)
echo  > system_file_contexts
echo > system_fs_config

for lib in "${lib_files[@]}"
do
	sed -i '$a /system/system/lib/'"${lib}"'.so u:object_r:system_lib_file:s0' system_file_contexts
	sed -i '$a /system/system/lib64/'"${lib}"'.so u:object_r:system_lib_file:s0' system_file_contexts
	sed -i '$a system/system/lib/'"${lib}"'.so 0 0 0644' system_fs_config
	sed -i '$a system/system/lib64/'"${lib}"'.so 0 0 0644' system_fs_config
done

# Handle apk lib & odex
######## App Market
# lib dir
sed -i '$a /system/system/priv-app/com\\.huawei\\.appmarket/lib u:object_r:system_file:s0' system_file_contexts
sed -i '$a /system/system/priv-app/com\\.huawei\\.appmarket/lib/arm64 u:object_r:system_file:s0' system_file_contexts
sed -i '$a system/system/priv-app/com.huawei.appmarket/lib 0 0 0755' system_fs_config
sed -i '$a system/system/priv-app/com.huawei.appmarket/lib/arm64 0 0 0755' system_fs_config

for market_lib in "${market_lib_files[@]}"
do
	sed -i '$a /system/system/priv-app/com\\.huawei\\.appmarket/lib/arm64/'"${market_lib}"'.so u:object_r:system_lib_file:s0' system_file_contexts
	sed -i '$a system/system/priv-app/com.huawei.appmarket/lib/arm64/'"${market_lib}"'.so 0 0 0644' system_fs_config
done

# odex dir
sed -i '$a /system/system/priv-app/com\\.huawei\\.appmarket/oat u:object_r:system_file:s0' system_file_contexts
sed -i '$a /system/system/priv-app/com\\.huawei\\.appmarket/oat/arm64 u:object_r:system_file:s0' system_file_contexts
sed -i '$a system/system/priv-app/com.huawei.appmarket/oat 0 0 0755' system_fs_config
sed -i '$a system/system/priv-app/com.huawei.appmarket/oat/arm64  0 0 0755' system_fs_config

sed -i '$a /system/system/priv-app/com\\.huawei\\.appmarket/oat/arm64/base\\.odex u:object_r:system_file:s0' system_file_contexts
sed -i '$a /system/system/priv-app/com\\.huawei\\.appmarket/oat/arm64/base\\.vdex u:object_r:system_file:s0' system_file_contexts
sed -i '$a system/system/priv-app/com.huawei.appmarket/oat/arm64/base.odex 0 0 0644' system_fs_config
sed -i '$a system/system/priv-app/com.huawei.appmarket/oat/arm64/base.vdex 0 0 0644' system_fs_config

# apk file
sed -i '$a /system/system/priv-app/com\\.huawei\\.appmarket u:object_r:system_file:s0' system_file_contexts
sed -i '$a /system/system/priv-app/com\\.huawei\\.appmarket/com\\.huawei\\.appmarket\\.apk u:object_r:system_file:s0' system_file_contexts
sed -i '$a system/system/priv-app/com.huawei.appmarket 0 0 0755' system_fs_config
sed -i '$a system/system/priv-app/com.huawei.appmarket/com.huawei.appmarket.apk 0 0 0644' system_fs_config

######## HMSCore
# lib dir
sed -i '$a /system/system/app/com\\.huawei\\.hwid/lib u:object_r:system_file:s0' system_file_contexts
sed -i '$a /system/system/app/com\\.huawei\\.hwid/lib/arm64 u:object_r:system_file:s0' system_file_contexts

sed -i '$a system/system/app/com.huawei.hwid/lib 0 0 0755' system_fs_config
sed -i '$a system/system/app/com.huawei.hwid/lib/arm64 0 0 0755' system_fs_config

sed -i '$a /system/system/app/com\\.huawei\\.hwid/lib/arm64/libaegissec.so u:object_r:system_lib_file:s0' system_file_contexts
sed -i '$a /system/system/app/com\\.huawei\\.hwid/lib/arm64/libdex2oat-util.so u:object_r:system_lib_file:s0' system_file_contexts

sed -i '$a system/system/app/com.huawei.hwid/lib/arm64/libaegissec.so 0 0 0644' system_fs_config
sed -i '$a system/system/app/com.huawei.hwid/lib/arm64/libdex2oat-util.so 0 0 0644' system_fs_config

# odex dir
sed -i '$a /system/system/app/com\\.huawei\\.hwid/oat u:object_r:system_file:s0' system_file_contexts
sed -i '$a /system/system/app/com\\.huawei\\.hwid/oat/arm64 u:object_r:system_file:s0' system_file_contexts

sed -i '$a system/system/app/com.huawei.hwid/oat 0 0 0755' system_fs_config
sed -i '$a system/system/app/com.huawei.hwid/oat/arm64 0 0 0755' system_fs_config

sed -i '$a /system/system/app/com\\.huawei\\.hwid/oat/arm64/base\\.odex u:object_r:system_file:s0' system_file_contexts
sed -i '$a /system/system/app/com\\.huawei\\.hwid/oat/arm64/base\\.vdex u:object_r:system_file:s0' system_file_contexts

sed -i '$a system/system/app/com.huawei.hwid/oat/arm64/base.odex 0 0 0644' system_fs_config
sed -i '$a system/system/app/com.huawei.hwid/oat/arm64/base.vdex 0 0 0644' system_fs_config

# apk file
sed -i '$a /system/system/app/com\\.huawei\\.hwid u:object_r:system_file:s0' system_file_contexts
sed -i '$a /system/system/app/com\\.huawei\\.hwid/com\\.huawei\\.hwid\\.apk u:object_r:system_file:s0' system_file_contexts
sed -i '$a system/system/app/com.huawei.hwid 0 0 0755' system_fs_config
sed -i '$a system/system/app/com.huawei.hwid/com.huawei.hwid.apk 0 0 0644' system_fs_config
