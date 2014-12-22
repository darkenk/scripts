CURRENT_DIR=`pwd`
mkdir -p ~/.config/QtProject/qtcreator/styles
ln -s ${CURRENT_DIR}/zenburn.xml ~/.config/QtProject/qtcreator/styles/zenburn.xml
ln -s ${CURRENT_DIR}/solarized-light.xml ~/.config/QtProject/qtcreator/styles/solarized-light.xml
ln -s ${CURRENT_DIR}/solarized-dark.xml ~/.config/QtProejct/qtcreator/styles/solarized-dark.xml
mkdir -p ~/.config/QtProject/qtcreator/themes/
ln -s ${CURRENT_DIR}/solarized-light.creatortheme ~/.config/QtProject/qtcreator/themes/solarized-light.creatortheme
ln -s ${CURRENT_DIR}/solarized-dark.creatortheme ~/.config/QtProject/qtcreator/themes/solarized-dark.creatortheme
