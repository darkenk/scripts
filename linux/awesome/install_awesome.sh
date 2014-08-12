#!/bin/bash
sudo cp ./awesome.session /usr/share/gnome-session/sessions/
sudo cp ./awesome.desktop /usr/share/applications/
sudo cp ./awesome-gnome.desktop /usr/share/xsessions/

for i in `grep -rl "OnlyShowIn.*GNOME" /etc/xdg/autostart/`
do
    sudo sed -i -e 's/OnlyShowIn=.*/&Awesome;/' $i
done
cp ./rc.lua ~/.config/awesome
