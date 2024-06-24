# Como habilitar o tun/tap em um container LXC


## No container especifico que desejar alterar coloque:
**/etc/pve/lxc/<nnn>.conf**

```
lxc.cgroup.devices.allow: c 10:200 rwm
lxc.mount.entry: /dev/net dev/net none bind,create=dir
```


Após editar o arquivo de configuração, reinicie o contêiner para aplicar as mudanças:

```
sudo lxc-stop -n <nome_do_container>
sudo lxc-start -n <nome_do_container>
```
