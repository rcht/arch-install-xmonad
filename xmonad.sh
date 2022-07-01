sudo pacman -S wget stack xorg-server xorg-apps xorg-xinit xorg-xmessage libx11 libxft libxinerama libxss pkgconf

mkdir -p ~/.config/xmonad && cd ~/.config/xmonad
mkdir -p ~/.config/xmobar

wget https://raw.githubusercontent.com/rcht/dotfiles/master/.xmonad/xmonad.hs
wget -O ~/.config/xmobar/xmobar.hs https://raw.githubusercontent.com/rcht/dotfiles/master/.config/xmobar/xmobar.hs
wget -O ~/.config/xmobar/haskell.xpm https://raw.githubusercontent.com/rcht/dotfiles/master/.config/xmobar/haskell.xpm

git clone https://github.com/xmonad/xmonad
git clone https://github.com/xmonad/xmonad-contrib

stack init
stack install
xmonad --recompile

sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
sudo systemctl enable lightdm

[[ -d "/usr/share/xsessions/" ]] || sudo mkdir -p /usr/share/xsessions/

sudo cat > /usr/share/xsessions/xmonad.desktop << "EOF"
[Desktop Entry]
Version=1.0
Type=Application
Name=Xmonad
Comment=Lightweight X11 tiled window manager written in Haskell
Exec=xmonad
Icon=xmonad
Terminal=false
StartupNotify=false
Categories=Application;
EOF
