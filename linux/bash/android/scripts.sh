# Copyright (C) 2014, Dariusz Kluska <darkenk@gmail.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# * Neither the name of the {organization} nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# dsetup_android_lunch
function dsetup_android_lunch {
    if [ $# == 1 ]; then
        echo $1 > ${ANDROID_BUILD_TOP}/last_lunch
    else
        echo "use dsetup_android_lunch target"
    fi
}

function dandroid_lunch {
    if [ -e last_lunch ]; then
        last_lunch=$(cat last_lunch)
        echo "Launching last lunch ("${last_lunch}", you can change lunch by dsetup_android_lunch new_target"
        lunch ${last_lunch}
    else
        lunch
    fi
}

function dautopush {
    echo "Please connect device"
    if [ $(adb get-state) = "unknown" ]; then
        adb wait-for-device
    fi
    adb root
    adb remount
    rm ${ANDROID_BUILD_TOP}/last_mmm
    while read line
    do
        echo ${line}
        echo ${line} >> ${ANDROID_BUILD_TOP}/last_mmm
    done
    prefix=${OUT#$ANDROID_BUILD_TOP/};
    for path in "$(cat ${ANDROID_BUILD_TOP}/last_mmm | grep Install)"
    do
        if [ -z "${path}" ]; then
            continue
        fi
        path=${path#"Install: "}
        dev_path=${path#$prefix}
        echo Pushing ${ANDROID_BUILD_TOP}/${path} to ${dev_path}
        adb push ${ANDROID_BUILD_TOP}/${path} ${dev_path}
    done
}
