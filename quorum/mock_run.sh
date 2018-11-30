docker run -it --rm -e LAUNCH_PARAMETERS="--nodiscover --syncmode full --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum" -e NODE_ID=0 -e NETWORK_ID=5 -e RPC_PORT=8545 -e P2P_PORT=30303 -v ~/GOPATH/src/github.com/jpmorganchase/quorum/genesis_data:/genesis_data quorum:latest /bin/bash geth.sh

