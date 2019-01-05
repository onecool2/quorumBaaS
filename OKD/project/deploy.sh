oc new-project test2
oc new-app -f ./quorumtesserapv.yaml -p PROJECTNAME=test2
oc new-app -f ./initjob.yaml -p NODENUMBER=3 -p PASSWORD="abc"

oc new-app -f ./quorumtessera_miner.yaml -p NODE_ID=1
oc new-app -f ./quorumtessera_miner.yaml -p NODE_ID=2
oc new-app -f ./quorumtessera_miner.yaml -p NODE_ID=3
oc new-app -f ./quorum_fullnode.yaml -p NODE_ID=1
oc new-app -f ./quorum_fullnode.yaml -p NODE_ID=2

oc new-app -f ./quorumRpcSvc.yaml -p PUB_RPC_PORT=32000

oc new-app -f ./quorum_explorer.yaml -p URL="www.test2-explorer.com" -p API_URL="http://baas-env-pre-public:32000" -p API_PORT=32000
