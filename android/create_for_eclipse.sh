BUILD_SCRIPT=dbuild.sh

echo -e "#!/bin/bash" > ${BUILD_SCRIPT}
echo -e "PROJECT_PATH=\$1" >> ${BUILD_SCRIPT}
echo -e "if [ -z \${PROJECT_PATH} ]; then" >> ${BUILD_SCRIPT}
echo -e "    echo \"Please provide which project need to be build, eg external/test/Android.mk\"" >> ${BUILD_SCRIPT}
echo -e "    exit" >> ${BUILD_SCRIPT}
echo -e "fi\n" >> ${BUILD_SCRIPT}

echo -e "export $(env | grep ANDROID_BUILD_TOP)" >> ${BUILD_SCRIPT}

env | grep -v -E "ORBIT_SOCKETDIR=|SSH_AGENT_PID=|TERMINATOR_UUID=|GPG_AGENT_INFO=|TERM=|SHELL=|XDG_SESSION_COOKIE=|WINDOWID=|GNOME_KEYRING_CONTROL=|GTK_MODULES=|USER=|http_proxy=|LS_COLORS=|XDG_SESSION_PATH=|XDG_SEAT_PATH=|SSH_AUTH_SOCK=|ftp_proxy=|SESSION_MANAGER=|DEFAULTS_PATH=|XDG_CONFIG_DIRS=|DESKTOP_SESSION=|PWD=|EDITOR=|GNOME_KEYRING_PID=|LANG=|MANDATORY_PATH=|UBUNTU_MENUPROXY=|https_proxy=|GDMSESSION=|SPEECHD_PORT=|SHLVL=|HOME=|LANGUAGE=|GNOME_DESKTOP_SESSION_ID=|LOGNAME=|XDG_DATA_DIRS=|DBUS_SESSION_BUS_ADDRESS=|LESSOPEN=|DISPLAY=|XDG_CURRENT_DESKTOP=|LESSCLOSE=|COLORTERM=|XAUTHORITY=|_=|ANDROID_BUILD_TOP" | sed 's/$/ \\/' >> ${BUILD_SCRIPT}
echo -e "PWD=\${ANDROID_BUILD_TOP} \\" >> ${BUILD_SCRIPT}
echo -e "ONE_SHOT_MAKEFILE=\"\$PROJECT_PATH\" make -C \${ANDROID_BUILD_TOP} -f build/core/main.mk all_modules -B showcommands" >> ${BUILD_SCRIPT}

RUN_SCRIPT=drun.sh
echo -e "#!/bin/bash" > ${RUN_SCRIPT}
echo -e "APP_NAME= " >> ${RUN_SCRIPT}
echo -e "adb push ${OUT}/system/bin/\${APP_NAME} /system/bin" >> ${RUN_SCRIPT}
echo -e "adb shell \${APP_NAME}" >> ${RUN_SCRIPT}
