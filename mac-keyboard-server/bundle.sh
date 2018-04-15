
if [ -f ./M-board.dmg ]; then
    echo "dmg exist rm first"
    rm ./M-board.dmg
    electron-installer-dmg . M-board --icon=./logo.icns
else
    electron-installer-dmg . M-board --icon=./logo.icns
    echo "dmg created"
fi


electron-packager .  M-board --overwrite --icon=./logo.icns

