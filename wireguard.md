# Como configurar WireGuard no easyPanel.




▶️ **Colar dentro do EasyPanel**

```
WG_HOST=
PASSWORD=
WG_PORT=13773
WG_PERSISTENT_KEEPALIVE=25
WG_DEFAULT_DNS=1.1.1.1
UI_TRAFFIC_STATS=true
WG_MTU=1412
WG_DEVICE=eth0
```
![image](https://github.com/julianol1berato/docker/assets/6303689/16dffe70-8ce5-4d06-a1f4-5ac5f166e893)


▶️ **Dentro do Container executar:**

```iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE```
