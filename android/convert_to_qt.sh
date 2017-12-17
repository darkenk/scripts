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
#
# This script creates qt project from Android.mk (only cpp)
# usage:
# source convert_to_qt.sh frameworks/native/services/surfaceflinger

echo "Generate project for $1"

PROJECT_DIR="$1"
PROJECT_NAME=`basename ${PROJECT_DIR}`
ANDROID_ROOT=`echo "${PROJECT_DIR}" | sed -r -e 's/[^\/]*\//\.\.\\\//g'`
MAKE_OUTPUT="/tmp/convert_to_qt.txt"
PROJECT_OUT=`dirname ${PROJECT_DIR}`/${PROJECT_NAME}
echo "${PROJECT_OUT}"

mmm --dry-run -B showcommands ${PROJECT_DIR} &> ${MAKE_OUTPUT}

mkdir -p ${PROJECT_OUT}

grep -E "g\+\+|gcc " ${MAKE_OUTPUT} | sed -e 's/-I[ ]*/-I/g' -e 's/-isystem[ ]*/-isystem/g' | tr "[:space:]" "\n" | grep --color -e "^-I" -e "^-isystem" | sed -e "s/-I/${ANDROID_ROOT}/" -e "s/-isystem/${ANDROID_ROOT}/" | sort -u > ${PROJECT_OUT}/${PROJECT_NAME}.includes

grep -E "g\+\+|gcc " ${MAKE_OUTPUT} | tr "[:space:]" "\n" | grep ^-D | sed -e 's/^-D/#define /' -e 's/=\|=\\\"/ /' -e 's/\\\"$//' | sort -u > ${PROJECT_OUT}/${PROJECT_NAME}.config

find ${PROJECT_DIR} -name "*\.h" -o -name "*\.c" -o -name "*\.hpp" -o -name "*\.cpp" | sed -e "s/^/${ANDROID_ROOT}/" > ${PROJECT_OUT}/${PROJECT_NAME}.files

echo "[General]" > ${PROJECT_OUT}/${PROJECT_NAME}.creator

rm ${MAKE_OUTPUT}
