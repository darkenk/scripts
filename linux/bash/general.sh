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

function deditConfig {
    vim ${DCUR_WORKSPACE_DIR}/setup_env.sh
}

function dgoToConfig {
    cd ${DCUR_WORKSPACE_DIR}
}

function deditScripts {
    mc ${DCUR_WORKSPACE_DIR}
}

function dgetCurrentDir {
    echo $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
}

function dloadScripts {
    if [ 1 -ne $# ]; then
        echo "dloadScirpts doesn't now what to load"
        return
    fi
    local files=$(ls $1 | grep .sh)
    for i in ${files}; do
        if [ "$(head -n 1 $i)" = "#!/bin/bash" ]; then
            source "$i"
        fi
    done
}

function daddAlias {
    alias | grep "${1}" && echo "You override previously created alias. See above";
    echo "alias ${1}='${2}'" >> ${DCUR_WORKSPACE_DIR}/setup_env.sh
    alias ${1}="${2}"
}

dsave_function () {
    local ORIG_FUNC=$(declare -f $1)
    local NEWNAME_FUNC="$2${ORIG_FUNC#$1}"
    eval "$NEWNAME_FUNC"
}

dhighlight () {
    local MATCH="\x1b[1;31m";
    local LINE="\x1b[1;33m";
    local NORMAL="\x1b[0;0m";
    sed -re "s/(.*)($1)(.*)/$LINE\1$MATCH\2$LINE\3$NORMAL/"
}

function dconvert_to_eclipse() {
    local path=$(dgetCurrentDir)
    source ${path}/../../android/convert_to_eclipse.sh $@
}

function dcommandDescription {
    echo ${1} - ${2}
}

function dhelp {
    dcommandDescription deditConfig "edit current config"
    dcommandDescription dgoToConfig "goes to config directory"
    dcommandDescription deditScripts "launch mc for editing all scripts in config directory"
    dcommandDescription dgetCurrentDir "returns current directory, usefull for scripts"
    dcommandDescription dloadScripts "helper function for loading scripts from directory passed as arg"
    dcommandDescription dhighlight "similar to grep, but only highlight search word"
    dcommandDescription daddAlias "add alias to current configuration"
}

alias ls='ls --color=auto'
alias grep='grep --color=auto'
