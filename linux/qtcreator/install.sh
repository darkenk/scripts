CURRENT_DIR=`pwd`
mkdir -p ~/.config/QtProject/qtcreator/styles
ln -s ${CURRENT_DIR}/zenburn.xml ~/.config/QtProject/qtcreator/styles/zenburn.xml
ln -s ${CURRENT_DIR}/solarized-light.xml ~/.config/QtProject/qtcreator/styles/solarized-light.xml
mkdir -p ~/.config/QtProject/qtcreator/themes/
ln -s ${CURRENT_DIR}/solarized-light.creatortheme ~/.config/QtProject/qtcreator/themes/solarized-light.creatortheme
