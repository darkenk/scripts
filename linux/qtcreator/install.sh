CURRENT_DIR=`pwd`
QT_CONFIG_DIR=~/.config/QtProject/qtcreator

function create_dir {
    rmdir ${QT_CONFIG_DIR}/$1
    if [ ! -h ${QT_CONFIG_DIR}/$1 ]; then
        ln -s ${CURRENT_DIR}/$1 ${QT_CONFIG_DIR}/$1
    fi
}

create_dir styles
create_dir themes
create_dir templates
