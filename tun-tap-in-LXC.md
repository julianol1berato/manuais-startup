# Como habilitar o tun/tap em um container LXC


## No container especifico que desejar alterar coloque:
**/etc/pve/lxc/<nnn>.conf**

```
lxc.cgroup.devices.allow: c 10:200 rwm
lxc.mount.entry: /dev/net dev/net none bind,create=dir
```
