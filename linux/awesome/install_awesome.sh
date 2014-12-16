#!/bin/bash
#sudo apt-get install awesome
#sudo cp ./awesome.session /usr/share/gnome-session/sessions/
#sudo cp ./awesome.desktop /usr/share/applications/
#sudo cp ./awesome-gnome.desktop /usr/share/xsessions/

#for i in `grep -rl "OnlyShowIn.*GNOME" /etc/xdg/autostart/`
#do
#    sudo sed -i -e 's/OnlyShowIn=.*/&Awesome;/' $i
#done
for i in `grep -rl "OnlyShowIn.*GNOME" /usr/share/applications/`
do
    sudo sed -i -e 's/OnlyShowIn=.*/&Awesome;/' $i
done
#mkdir -p ~/.config/awesome/
#ln -s `pwd`/rc3.4.lua ~/.config/awesome/
