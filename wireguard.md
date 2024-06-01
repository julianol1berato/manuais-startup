# Como configurar WireGuard no easyPanel.


▶️ **Colar dentro do EasyPanel**

```
WG_HOST=
PASSWORD=
WG_PORT=51821
WG_PERSISTENT_KEEPALIVE=25
WG_DEFAULT_DNS=1.1.1.1
UI_TRAFFIC_STATS=true
WG_MTU=1412
WG_DEVICE=eth2 #Ethernet device the wireguard traffic should be forwarded through.
WG_ALLOWED_IPS=0.0.0.0/1,128.0.0.0/1,::/1,8000::/1
UI_TRAFFIC_STATS=true
UI_CHART_TYPE=0 # (0 Charts disabled, 1 # Line chart, 2 # Area chart, 3 # Bar chart)
TZ: "America/Sao_Paulo"
WG_POST_UP="iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE; iptables -A INPUT -p udp -m udp --dport 51821 -j ACCEPT; iptables -A FORWARD -i wg0 -j ACCEPT; iptables -A FORWARD -o wg0 -j ACCEPT;"
WG_POST_DOWN="iptables -t nat -D POSTROUTING -o eth2 -j MASQUERADE; iptables -D INPUT -p udp -m udp --dport 51821 -j ACCEPT; iptables -D FORWARD -i wg0 -j ACCEPT; iptables -D FORWARD -o wg0 -j ACCEPT;"
```
![image](https://github.com/julianol1berato/docker/assets/6303689/256f05ff-0a0b-4871-9816-eccc59e21fe4)



▶️ **Dentro do Container executar:**

```iptables -t nat -A POSTROUTING -o eth2 -j MASQUERADE```
