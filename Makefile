# Arch 系统配置自动化脚本
#
# 配置主要包括几个方面：
# - 基本配置
# - 工具安装
# - 工具配置

PACMAN = pacman
PACMAN_OPTION = -S

YAY = $(prefix)/yay

prefix ?= /usr/bin
current_dir ?= $(shell pwd)

GIT = $(prefix)/git
GIT_NAME = git

NPM = $(prefix)/npm
NPM_NAME = npm nodejs

GVIM = $(prefix)/gvim
GVIM_NAME = gvim

FZF = ~/.fzf/bin/fzf
FZF_NAME = fzf

AG = $(prefix)/ag
AG_NAME = the_silver_searcher

init_config = set_time set_user set_mirrors install_tools config_files
vim_dep = $(GIT) $(NPM) $(GVIM) $(FZF) $(AG)

tools ?= iw wpa_supplicant dialog bash-completion xorg xorg-xinit xf86-video-nouveau awesome \
				terminator chromium firefox wqy-microhei fcitx fcitx-im fcitx-configtool fcitx-sunpinyin \
				shadowsocks-qt5 ranger thunar ntfs-3g gvfs-mtp gvim httpie mysql-workbench bat
aur_tools ?= xmind okular mycli

.PHONY: all
all: $(init_config)
	@echo ''
	@echo -e '\033[0;31mInitializing Arch System Done, Enjoy It.\033[0m'
	@echo ''

.PHONY: set_time
set_time:
	@echo ''
	@echo 'Config charset and timezone.'
	@sed -i -e '/#en_US\.UTF-8/s/^.//' -e '/#zh_CN\.UTF-8/s/^.//' /etc/locale.gen
	@locale-gen 2>&1 > /dev/null
	@echo LANG=en_US.UTF-8 > /etc/locale.conf
	@ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	@hwclock --systohc

.PHONY: set_user
set_user:
	@echo ''
	@echo 'Config User.'
	@echo codcodog > /etc/hostname
	@echo ''
	@echo 'Set password for root.'
	@passwd
	@useradd -m -g users -G wheel,storage,power -s /bin/bash cryven
	@echo ''
	@echo 'Set password for cryven'
	@passwd cryven
	@sed -i '/# %wheel ALL=(ALL) ALL/s/^..//' /etc/sudoers

.PHONY: set_mirrors
set_mirrors:
	@echo ''
	@echo 'Config mirrors.'
	@sed -i '6 a # China\
	Server = http://mirrors.163.com/archlinux/$$repo/os/$$arch\
	Server = http://mirrors.aliyun.com/archlinux/$$repo/os/$$arch\
	Server = http://mirrors.sohu.com/archlinux/$$repo/os/$$arch' /etc/pacman.d/mirrorlist

.PHONY: install_tools
install_tools:
	@echo ''
	@echo 'Install tools.'
	@$(PACMAN) $(PACMAN_OPTION) $(tools)
	@$(YAY) $(PACMAN_OPTION) $(aur_tools)

$(YAY):
	@echo ''
	@echo 'Install yay.'
	@git clone https://aur.archlinux.org/yay.git
	@cd yay && makepkg -si

.PHONY: config_files
config_files:
	@echo ''
	@echo 'Config tools.'
	@cp -f $(current_dir)/.Xmodmap ~
	@cp -f $(current_dir)/.bashrc ~
	@cp -f $(current_dir)/.gitconfig ~
	@cp -f $(current_dir)/.xinitrc ~
	@if [[ ! -d ~/.config/awesome ]] ; then \
		mkdir -p ~/.config/awesome; \
	fi
	@cp $(current_dir)/rc.lua ~/.config/awesome/rc.lua
	@cd ~/.config/awesome && git clone https://github.com/streetturtle/awesome-wm-widgets.git

$(GIT):
	@$(PACMAN) $(PACMAN_OPTION) $(GIT_NAME)

$(NPM):
	@$(PACMAN) $(PACMAN_OPTION) $(NPM_NAME)
	@$(NPM) -g install instant-markdown-d

$(GVIM):
	@$(PACMAN) $(PACMAN_OPTION) $(GVIM_NAME)

$(FZF):
	@$(PACMAN) $(PACMAN_OPTION) $(FZF_NAME)
	@cp -f /usr/share/fzf/key-bindings.bash ~/.fzf.bash

$(AG):
	@$(PACMAN) $(PACMAN_OPTION) $(AG_NAME)

.PHONY: vim
vim: $(vim_dep)
	@echo ''
	@echo 'Vim config.'
	@cp -rf $(current_dir)/.vim ~
	@cp -f $(current_dir)/.vimrc ~
	@vim +:PlugInstall
