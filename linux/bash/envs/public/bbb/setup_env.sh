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
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "${DIR}/../../../general.sh"

# Setup title for terminator
echo -en "\e]0;${DCUR_WORKSPACE}\a"

export PS1="\[\e[0;44m\]${debian_chroot:+($debian_chroot)}\u@${DCUR_WORKSPACE}:\w\$\[\e[0m\] "

#export CC=~/workspace/projects/bbb/bb-kernel/dl/gcc-linaro-4.9-2014.11-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-
export CC=arm-linux-gnueabihf-
export DISK=/dev/mmcblk0

export DK_BBB_HOME=/home/darkenk/workspace/projects/bbb
export INSTALL_MOD_PATH=~/workspace/projects/bbb/kernel/KERNEL/out
export INSTALL_FW_PATH=${INSTALL_MOD_PATH}
export INSTALL_DTBS_PATH=${INSTALL_MOD_PATH}
#export KBUILD_OUTPUT=${DK_BBB_HOME}/u-boot_build
export ARCH=arm
export CROSS_COMPILE=${CC}
export LOADADDR=0x82000000

export GRAPHICS_INSTALL_DIR=~/workspace/projects/bbb/kernel/ti-sdk-pvr/Graphics_SDK
export KERNEL_INSTALL_DIR=~/workspace/projects/bbb/kernel/KERNEL
export CSTOOL_PREFIX=${CC}
export CSTOOL_DIR=/usr/
export OMAPES=8.x

cd ~/workspace/projects/bbb/kernel/KERNEL

#alias rebuild_kernel="make -j8 ARCH=arm LOCALVERSION=-bone5 CROSS_COMPILE=/home/darkenk/workspace/projects/bbb/mine/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux/bin/arm-linux-gnueabihf-  zImage modules"
