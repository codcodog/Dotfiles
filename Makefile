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
# 3. 初步配置完成之后，重启登录用户帐号，执行：`make install`
# 4. Vim YouCompleteMe 插件只是下载源码回来，并没进行安装
#    详情参考：https://github.com/ycm-core/YouCompleteMe#linux-64-bit

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

FZF = $(prefix)/fzf
FZF_NAME = fzf

AG = $(prefix)/ag
AG_NAME = the_silver_searcher

system_config = set_time set_user set_mirrors config_files install_tools 
user_name = h2O
home = /home/$(user_name)
vim_dep = $(GIT) $(NPM) $(GVIM) $(FZF) $(AG)

GRUB_NAME = grub
GRUB = $(prefix)/$(GRUB_NAME)
dev_sdx ?= /dev/sda # 硬盘

tools ?= iw wpa_supplicant dialog bash-completion xorg xorg-xinit xf86-video-nouveau awesome \
				terminator chromium firefox wqy-microhei fcitx fcitx-im fcitx-configtool fcitx-sunpinyin \
				shadowsocks-qt5 ranger thunar ntfs-3g gvfs-mtp gvim httpie mysql-workbench bat ctags feh \
				arandr openssh flameshot docker docker-compose cmake netctl dhcpcd tldr
aur_tools ?= xmind okular mycli office-code-pro

.PHONY: all
all: $(system_config)
	@echo ''
	@echo -e '\033[0;31mInitializing Arch System Done, But System Boot Not Installed Yet.\033[0m'
	@echo -e '\033[0;31mRun `make grub` or install it manually.\033[0m'
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
	useradd -m -g users -G wheel,storage,power -s /bin/bash $(user_name)
	@echo ''
	@echo 'Set password for $(user_name)'
	@passwd $(user_name)
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

$(home): set_user

.PHONY: config_files
config_files: $(home)
	@echo ''
	@echo 'Config tools.'
	cp -f $(current_dir)/.Xmodmap $(home)
	cp -f $(current_dir)/.bashrc $(home)
	cp -f $(current_dir)/.gitconfig $(home)
	cp -f $(current_dir)/.xinitrc $(home)
	@if [[ ! -d $(home)/.config/awesome ]] ; then \
		mkdir -p $(home)/.config/awesome; \
	fi
	@if [[ ! -d $(home)/.config/terminator ]] ; then \
		mkdir -p $(home)/.config/terminator; \
	fi
	cp -f $(current_dir)/config $(home)/.config/terminator/config
	cp -f $(current_dir)/rc.lua $(home)/.config/awesome/rc.lua
	chown -R $(user_name):users $(home)/.config # Note: give permission back to user.

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
	@systemctl restart openntpd # restart to adjust time.

.PHONY: docker_config
docker_config:
	@echo ''
	@echo 'Docker config for no sudo.'
	@sudo groupadd docker || true
	@sudo usermod -aG docker $$USER

$(GIT):
	@echo ''
	@echo 'Install $(GIT_NAME).'
	@$(YAY) $(PACMAN_OPTION) $(GIT_NAME)

$(NPM):
	@echo ''
	@echo 'Install $(NPM_NAME).'
	@$(YAY) $(PACMAN_OPTION) $(NPM_NAME)
	@sudo $(NPM) install -g instant-markdown-d

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
