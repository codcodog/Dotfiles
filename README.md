配置文件
========
本仓库主要是备份个人常用的配置文件.  

### 如何使用
`Arch` 基础系统安装完成，`arch-root` 之后，运行
```bash
$ make
```

`grub` 引导安装
```bash
$ make grub
```
> grub 安装需要 dos 分区而不是 gpt 分区

`system boot` 安装参考：[system boot 安装](https://github.com/codcodog/Blog/issues/105)

重启登录之后
```bash
$ make install
```
安装完成之后，重新打开 `terminator` 或者重启系统.
