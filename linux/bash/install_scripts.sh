#!/bin/bash
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

ENV_BEGIN="#DARKENK ENV BEGIN"
ENV_END="#DARKENK ENV END"
BASH_FILE=~/.bashrc

if [ -e ${BASH_FILE} ]; then
    RESULT=`grep "${ENV_BEGIN}" ${BASH_FILE}`
    if [ -n "${RESULT}" ]; then
        echo -n "Scripts have been already installed. Do you want to reinstall? (Y/n) ";
        read REINSTALL
        if [ Y != "${REINSTALL}" ]; then
            echo "OK, abort installation"
            exit 0
        else
            echo "Reinstallation has just begun"
            sed -i "/^${ENV_BEGIN}/,/^${ENV_END}/d" ${BASH_FILE}
        fi
    else
        echo "Fresh installation"
    fi
fi

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
echo ${ENV_BEGIN} >> ${BASH_FILE}
echo "D_ENV_DIR="${DIR}"/envs" >> ${BASH_FILE}
cat "${DIR}/envs_scripts" >> ${BASH_FILE}
echo ${ENV_END} >> ${BASH_FILE}
echo Installation completed
