#!/bin/bash
echo Wait 25 seconds for tessera is ready
i=500
while [ $i -ge 0 ]
do
    if [ -w "/tesserasocket/tm.ipc" ];then
        break
    fi
    sleep 5
    let i-=1
    echo $i
done

if [ $i == -1 ]; then
   echo "Couldn't start quorum"
   exit -1
fi
echo "Found tessera ipc socket, continue starting quorum"

cp -r /shareStorage/node${NODE_ID}/quorum ~/quorum
geth --datadir ~/quorum init /shareStorage/clique-genesis.json
touch ~/quorum/password
PRIVATE_CONFIG=/tesserasocket/tm.ipc geth $LAUNCH_GETH_PARAMETERS --password ~/quorum/password --unlock 0xed9d02e382b34818e88b88a309c7fe71e65f419d --etherbase 0xed9d02e382b34818e88b88a309c7fe71e65f419d --datadir ~/quorum --networkid ${NETWORK_ID} --rpcport ${RPC_PORT} --port ${P2P_PORT} 
