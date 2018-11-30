mv /shareStorage/node${NODE_ID}/quorum ~/quorum
geth --datadir ~/quorum init /shareStorage/clique-genesis.json
geth $LAUNCH_PARAMETERS PRIVATE_CONFIG=$DDIR/tm.ipc --datadir ~/node${NODE_ID} --networkid ${NETWORK_ID} --rpcport ${RPC_PORT} --port ${P2P_PORT} 
