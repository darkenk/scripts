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
# This script creates eclipse project from Android.mk (only cpp). Copy
# script and tmpcproject and tmpproject into android root directory.
# usage:
# source convert_to_eclipse.sh frameworks/native/services/surfaceflinger

echo "Generate project for $1"

function _main_ {
    local dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
    local project_out_dir=eclipse
    local project_path="$1"
    local new_project_name=`basename ${project_path}`
    local template_project="${dir}/tmpproject"
    local path_to_new_project="/tmp/.project"
    local path_to_new_cproject="/tmp/.cproject"
    local template_cproject="${dir}/tmpcproject"
    local make_output="/tmp/log"
    local android_root=/../`echo ${project_path} | sed -r -e 's/[^\/]+/\.\./g' | sed -r -e 's/.+\.$/\0\//'`
    
    xmlstarlet ed -u /projectDescription/name -v ${new_project_name} ${template_project} | \
    xmlstarlet ed -u /projectDescription/linkedResources/link/name -v ${new_project_name} | \
    xmlstarlet ed -u /projectDescription/linkedResources/link/locationURI -v PARENT-5-PROJECT_LOC/${project_path} > ${path_to_new_project}
    local cproject=`xmlstarlet ed -u /cproject/storageModule/cconfiguration/storageModule/configuration/@artifactName -v ${new_project_name} ${template_cproject} | \
    xmlstarlet ed -u /cproject/storageModule/project/@id -v ${new_project_name}.null.1967302977 | \
    xmlstarlet ed -u /cproject/storageModule/project/@name -v ${new_project_name} | \
    xmlstarlet ed -u /cproject/storageModule/resource/@workspacePath -v ${project_path}`
    
    mmm -B showcommands ${project_path} &> ${make_output}
    
    local includes=`grep -E "g\+\+|gcc " ${make_output} | grep -o -E "(\-I [^ ]*)|(\-isystem [^ ]*)" | sort -u | sed -r -e "s/[^ ]* (.*)/\1/"`
    var=/cproject/storageModule/cconfiguration/storageModule/configuration/folderInfo/toolChain/tool/option[@valueType=\'includePath\']
    
    #TODO: read below values from g++
    #grep --color -o -E -m  1 "[^ ]*arm-linux-androideabi-g\+\+" ${make_output}
    includes=`echo -e "${includes}\nprebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.7/bin/../lib/gcc/arm-linux-androideabi/4.7/include\nprebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.7/bin/../lib/gcc/arm-linux-androideabi/4.7/include-fixed"`
    
    local ProjDirPath='${ProjDirPath}'
    
    for i in ${includes}
    do
        cproject=`echo -n "$cproject" | xmlstarlet ed -s ${var} -t elem -n listOptionValueTmp -v "" -i //listOptionValueTmp -t attr -n builtIn -v "false" -i //listOptionValueTmp -t attr -n "value" -v "\"\$ProjDirPath${android_root}${i}\"" -r //listOptionValueTmp -v listOptionValue`
    done
    
    local defines=`grep -E "g\+\+|gcc " ${make_output} | grep -o -E "\-D[^ ]*" | sort -u | sed -r -e "s/-D//"`
    var=/cproject/storageModule/cconfiguration/storageModule/configuration/folderInfo/toolChain/tool/option[@valueType=\'definedSymbols\']
    
    for i in ${defines}
    do
        cproject=`echo -n "$cproject" | xmlstarlet ed -s ${var} -t elem -n listOptionValueTmp -v "" -i //listOptionValueTmp -t attr -n builtIn -v "false" -i //listOptionValueTmp -t attr -n "value" -v "$i" -r //listOptionValueTmp -v listOptionValue`
    done
    
    local include_files=`grep -o -E "\-include [^ ]*" ${make_output} | sort -u | sed -e 's/-include //'`
    var=/cproject/storageModule/cconfiguration/storageModule/configuration/folderInfo/toolChain/tool/option[@valueType=\'includeFiles\']
    
    for i in ${include_files}
    do
        cproject=`echo -n "$cproject" | xmlstarlet ed -s ${var} -t elem -n listOptionValueTmp -v "" -i //listOptionValueTmp -t attr -n builtIn -v "false" -i //listOptionValueTmp -t attr -n "value" -v "\"\$ProjDirPath${android_root}${i}\"" -r //listOptionValueTmp -v listOptionValue`
    done
    
    echo -n "${cproject}" > ${path_to_new_cproject}
    mkdir -p ${project_out_dir}/${project_path}
    mv ${path_to_new_cproject} ${project_out_dir}/${project_path}
    mv ${path_to_new_project} ${project_out_dir}/${project_path}
    
    rm ${make_output}
    echo "Project saved to ${project_out_dir}/${project_path}"
}
type mmm &> /dev/null
if [ $? -eq 1 ]; then
    echo "Please run . build/envsetup.sh and choose proper android device"
else
    if [ -z `which xmlstarlet` ]; then
        echo "Please install xmlstarlet"
    else
        _main_ $1
    fi
fi
