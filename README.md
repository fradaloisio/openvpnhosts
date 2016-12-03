# OpenVPN hosts
OpenVPN DNS lookups by using /etc/hosts, mapping IP and Profile on the server.
You have to generate a profile for each client.


## usage
nohup ./openvpnhosts.sh &


## logs
By default you can find the logs here /var/log/openvpnhosts.log

When a new client connects to the server, the following log appears
```
[2016-12-02T22:00:21] [ADD] IPv4=10.8.0.6 Profile=testadroindvpn
```

When duplicates IPs or Profiles appears:

```
[2016-12-02T22:00:21] [DEL] IPv4=10.8.0.6 Profile=testadroindvpn
[2016-12-02T22:00:21] [DEL] IPv4=10.8.0.6 Profile=testadroindvpn2
[2016-12-02T22:00:21] [DEL] IPv4=10.8.0.7 Profile=testadroindvpn
[2016-12-02T22:00:21] [ADD] IPv4=10.8.0.6 Profile=testadroindvpn
```

## connection
ssh with your user
```bash
ssh user@testadroindvpn
```