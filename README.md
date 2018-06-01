配置文件
========
本仓库主要是备份一些个人常用的配置文件.  
运行系统：`Arch Linux`


### Arch 安装
```
$ ./arch_install
```
脚本安装配置完成之后，安装 System Boot.
> grub 安装参考 [Arch 安装和个人配置记录](https://github.com/codcodog/Blog/issues/74)

#### system-boot
> 主要针对 `gpt` 分区，固态硬盘.

安装 `bootloader`
```bash
# bootctl --path=/boot install
```
配置 `loader.conf`
```bash
# vim /boot/loader/loader.conf
```
```
default arch
timeout 3
editor 0
```

`root` 分区的 `UUID`
```bash
# blkid -s PARTUUID -o value /dev/nvme0n1p2
```

配置 `arch.conf`
```bash
# vim /boot/loader/entries/arch.conf
```
```
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=PARTUUID=66e3f67d-f59a-4086-acdd-a6e248a3ee80 rw
```

更新 `bootloader`
```bash
# bootctl update
```

添加 `nvme` 模块
```bash
# vim /etc/mkinitcpio.conf
```
```
MODULES="nvme"
```

更新 `bootloader`
```
# mkinitcpio -p linux
```

详细参考：[How to install Arch Linux on Dell XPS 13 (2016) in 7 steps](https://www.cio.com/article/3098030/linux/how-to-install-arch-linux-on-dell-xps-13-2016-in-7-steps.html#slide5)

### Vim 配置
```sh
$ ./vi_install
```

### 其他配置
```sh
$ ./other_install
```
