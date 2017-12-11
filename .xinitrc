# fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
exec fcitx & 2>/dev/null

# caps to ctrl
if [ -f $HOME/.Xmodmap ]; then
    /usr/bin/xmodmap $HOME/.Xmodmap
fi

# ss-qt5
exec ss-qt5 & 2>/dev/null

exec awesome
