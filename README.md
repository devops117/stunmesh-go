# stunmesh-go
STUNMESH is a Wireguard helper tool to get through Full-Cone NAT.

Inspired by manuels' [wireguard-p2p](https://github.com/manuels/wireguard-p2p) project

:warning: This PoC code is dirty and need refactor.

## Implement
Use raw socket and cBPF filter to send and receive STUN 5389's packet to get public ip and port with same port of wireguard interface.<br />
Encrypt public info with Curve25519 sealedbox and save it into Cloudflare DNS TXT record.<br />
stunmesh-go will create and update a record with domain `<sha1 in hex>.<your_domain>`.<br />
Once getting info from internet, it will setup peer endpoint with wireguard tools.<br />

stunmesh-go assume you only have one peer per wireguard interface.

Still need refactor to get plugin support

## Build for Linux in native environment
```
go build .
```

## Usage
Please edit `start.sh` and execute it with root privileges.<br />
You should use crontab to trigger stunmesh-go periodically to update Cloudflare TXT record and receive remote peer's public info. <br />

## Configuration

### start.sh
```
#!/bin/bash

export CF_API_TOKEN=<Your API Token>
export CF_ZONE_NAME=<Your Domain>

wg_interfaces=("wg02" "wg03")

for wg_interface in ${wg_interfaces[@]}
do
        echo $wg_interface
        export WG=$wg_interface
        /tmp/stunmesh-go
        sleep 10
        /tmp/stunmesh-go
done
```

## Future work / Roadmap

- daemon and one shot command
- auto execute when routing engine notify change
- plugin based storage
- config file via JSON or other format

## License
This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
