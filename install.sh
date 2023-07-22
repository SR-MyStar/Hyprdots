#!/bin/sh

DOTS=$(pwd)

1_make_home_dir()
{
    mkdir "$1"/.config || true
    mkdir "$1"/.cache || true
    mkdir -p "$1"/.local/share/fonts || true
}

1_backup()
{
  echo "\e[32mBakuping configures..."
  mkdir $HOME/.oldconfig
  mv -v $HOME/.config/{bat,btop,cava,dunst,fcitx5,hypr,nemo,neofetch,rofi,waybar,wezterm,wlogout,zsh} $HOME/.oldconfig

  echo "\e[32mBakuping local files..."
  mkdir $HOME/.oldconfig/local
  mv -v $HOME/.local/share/{rofi,fcitx5} $HOME/.oldconfig/local
  echo "\e[32mDone, you can find your backups at \e[33m$HOME/.oldconfig"
}


echo "\e[32mPreparing stuff..."
1_make_home_dir ${HOME} 2> /dev/null
echo "\e[32mDone"

echo "\e[31mWARNING: Is the hyprdots folder at \e[33m$(pwd)? \e[32m(y/N)"
read input
if [[ "$input" == "y" ]] || [[ "$input" == "Y" ]]
  then
    if [[ -d "$HOME/.oldconfig" ]] 
      then
        echo ""
        echo "\e[31mWARNING: There seems to already be a backup at \e[33m'$HOME/.oldconfig'"
        echo "\e[33mDo you wanna overwrite it \e[32m(y/N)?"
        read input
        if [[ "$input" == "y" ]] || [[ "$input" == "Y" ]] 
          then
            rm -rf "$HOME/.oldconfig"
            echo "\e[32mRedoing directory tree..."
            1_backup
          else
            echo "\e[31mDelete \e[33m$HOME/.oldconfig \e[31mmanually before installing"
            echo "\e[32mInstallation aborted"
            exit
            fi;
  else
    1_backup
fi;

echo "\e[32mInstall fonts..."
ln -s $DOTS/local/fonts $HOME/.local/share/fonts/10_hyprdots_fonts
echo "\e[32mDone"

echo "\e[32mInstall Configures..."
ln -s $DOTS/config/{bat,btop,cava,dunst,fcitx5,hypr,nemo,neofetch,rofi,waybar,wezterm,wlogout,zsh} $HOME/.config/
echo "\e[32mDone"

echo "\e[32mInstall local files..."
ln -s $DOTS/local/{rofi,fcitx5} $HOME/.local/share/
echo "\e[32mDone"

echo "\e[32mInstall finished"
echo "\e[33mThere's no need to run this again, to update just run \e[32mgit pull \e[31in $(pwd)"
echo "\e[32mEnjoy my rice :)"
else
   echo "\e[32mPlase change in hyprdots folder and run this"
   echo "\e[32mInstallation aborted"
   exit
fi;