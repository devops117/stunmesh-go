#!/bin/bash

export CF_API_TOKEN=
export CF_ZONE_NAME=

wg_interfaces=("wg0")

for wg_interface in ${wg_interfaces[@]}
do
	echo $wg_interface
	export WG=$wg_interface
	/tmp/stunmesh-go
	sleep 10s
	/tmp/stunmesh-go
done
