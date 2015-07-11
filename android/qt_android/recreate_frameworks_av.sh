#!/bin/bash -x

if [ -z ${ANDROID_BUILD_TOP} ]; then
    echo "Please set ANDROID_BUILD_TOP path"
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "Please specify destination folder"
    exit 1
fi
DK_destination_folder=$1
DK_project_name=frameworks_av
DK_android_project_path=${ANDROID_BUILD_TOP}/frameworks/av/

mkdir -p ${DK_destination_folder}
find ${DK_android_project_path} -regextype posix-egrep -regex ".*\.(cc|c|cpp|h|hpp|mk)$" > ${DK_destination_folder}/${DK_project_name}.files

DK_include_paths=(frameworks/native/include
system/core/include
bionic/libc/kernel/uapi
hardware/libhardware/include)

find ${DK_android_project_path} -type d > ${DK_destination_folder}/${DK_project_name}.includes
for i in ${DK_include_paths[*]} ; do
    echo "${ANDROID_BUILD_TOP}/${i}" >> ${DK_destination_folder}/${DK_project_name}.includes
done
touch ${DK_destination_folder}/${DK_project_name}.config
echo "[General]" >> ${DK_destination_folder}/${DK_project_name}.creator

DK_pre_env=`mktemp`
env | sort > ${DK_pre_env}
cd ${ANDROID_BUILD_TOP}
. build/envsetup.sh
lunch aosp_flo-eng
cd -
DK_post_env=`mktemp`
DK_temp=`mktemp`
env | sort > ${DK_post_env}
comm -13 ${DK_pre_env} ${DK_post_env} > ${DK_temp}
rm ${DK_pre_env} ${DK_post_env}
awk '{print "export " $0}' ${DK_temp} > ${DK_destination_folder}/android_env.txt
