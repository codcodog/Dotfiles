# Arch 系统配置自动化脚本
#
# Copyright (C) 2019 Cryven <codcodog at gmail dot com>
#
# 配置主要包括：
# - 基本配置
# - 工具安装
# - 工具配置
#
# 主要有以下几部分：
# 1. 基础系统安装，chroot 之后执行：`make`
# 2. 安装 grub （可选）
# 	- 分区若是 gpt 分区，/boot -> fat32
# 	- 分区若是 dos 分区，则直接安装 grub 即可
# 3. 初步配置完成之后，重启登录 cryven 帐号，执行：`make install`

PACMAN = pacman
PACMAN_OPTION = -S --noconfirm

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
cryven_home = /home/cryven
vim_dep = $(GIT) $(NPM) $(GVIM) $(FZF) $(AG)

GRUB = $(prefix)/grub
GRUB_NAME = grub
dev_sdx ?= /dev/sda # 硬盘

tools ?= iw wpa_supplicant dialog bash-completion xorg xorg-xinit xf86-video-nouveau awesome \
				terminator chromium firefox wqy-microhei fcitx fcitx-im fcitx-configtool fcitx-sunpinyin \
				shadowsocks-qt5 ranger thunar ntfs-3g gvfs-mtp gvim httpie mysql-workbench bat ctags feh \
				arandr
aur_tools ?= xmind okular mycli

.PHONY: all
all: $(init_config)
	@echo ''
	@echo -e '\033[0;31mInitializing Arch System Done, But System Boot Not Installed Yet.(Run `make grub` or install manually.)\033[0m'
	@echo ''

.PHONY: set_time
set_time:
	@echo ''
	@echo 'Config charset and timezone.'
	@sed -i -e '/#en_US\.UTF-8/s/^.//' -e '/#zh_CN\.UTF-8/s/^.//' /etc/locale.gen
	locale-gen
	echo LANG=en_US.UTF-8 > /etc/locale.conf
	ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	@$(PACMAN) $(PACMAN_OPTION) openntpd
	@systemctl enable openntpd

.PHONY: set_user
set_user:
	@echo ''
	@echo 'Config User.'
	echo codcodog > /etc/hostname
	@echo ''
	@echo 'Set password for root.'
	@passwd
	useradd -m -g users -G wheel,storage,power -s /bin/bash cryven
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

$(cryven_home): set_user

.PHONY: config_files
config_files: $(cryven_home)
	@echo ''
	@echo 'Config tools.'
	cp -f $(current_dir)/.Xmodmap $(cryven_home)
	cp -f $(current_dir)/.bashrc $(cryven_home)
	cp -f $(current_dir)/.gitconfig $(cryven_home)
	cp -f $(current_dir)/.xinitrc $(cryven_home)
	@if [[ ! -d $(cryven_home)/.config/awesome ]] ; then \
		mkdir -p $(cryven_home)/.config/awesome; \
	fi
	@if [[ ! -d $(cryven_home)/.config/terminator ]] ; then \
		mkdir -p $(cryven_home)/.config/terminator; \
	fi
	cp -f $(current_dir)/config $(cryven_home)/.config/terminator/config
	cp -f $(current_dir)/rc.lua $(cryven_home)/.config/awesome/rc.lua
	cd $(cryven_home)/.config/awesome && git clone https://github.com/streetturtle/awesome-wm-widgets.git
	chown -R cryven:users $(cryven_home)/.config # Note: 把权限给回 cryven 用户

$(GRUB):
	@$(PACMAN) $(PACMAN_OPTION) $(GRUB_NAME)

.PHONY: grub
grub: $(GRUB)
	@echo ''
	@echo 'Install grub'
	grub-install --target=i386-pc --recheck $(dev_sdx)
	grub-mkconfig -o /boot/grub/grub.cfg

$(YAY):
	@echo ''
	@echo 'Install yay.'
	@if [[ -d /tmp/yay ]] ; then \
		rm -rf /tmp/yay; \
	fi
	git clone https://aur.archlinux.org/yay.git /tmp/yay
	cd /tmp/yay && makepkg -si

install: aur_tools vim

.PHONY: aur_tools
aur_tools: $(YAY)
	@$(YAY) $(PACMAN_OPTION) $(aur_tools)

$(GIT):
	@echo ''
	@echo 'Install $(GIT_NAME).'
	@$(YAY) $(PACMAN_OPTION) $(GIT_NAME)

$(NPM):
	@echo ''
	@echo 'Install $(NPM_NAME).'
	@$(YAY) $(PACMAN_OPTION) $(NPM_NAME)
	@$(NPM) install -g instant-markdown-d

$(GVIM):
	@echo ''
	@echo 'Install $(GVIM_NAME)'
	@$(YAY) $(PACMAN_OPTION) $(GVIM_NAME)

$(FZF):
	@echo ''
	@echo 'Install $(FZF_NAME)'
	@$(YAY) $(PACMAN_OPTION) $(FZF_NAME)
	cp -f /usr/share/fzf/key-bindings.bash ~/.fzf.bash

$(AG):
	@echo ''
	@echo 'Install $(AG_NAME)'
	@$(YAY) $(PACMAN_OPTION) $(AG_NAME)

.PHONY: vim
vim: $(vim_dep)
	@echo ''
	@echo 'Vim config.'
	cp -rf $(current_dir)/.vim ~
	cp -f $(current_dir)/.vimrc ~
	vim +:PlugInstall
