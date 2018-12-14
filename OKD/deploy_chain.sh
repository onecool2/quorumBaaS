oc new-project test1
oc new-app -f ./quorumtesserapv.yaml -p PROJECTNAME=test1
oc new-app -f ./initjob.yaml -p NODENUMBER=3 -p PASSWORD="abc"

oc new-app -f ./quorumtessera_miner.yaml -p NODE_ID=1
oc new-app -f ./quorumtessera_miner.yaml -p NODE_ID=2
oc new-app -f ./quorumtessera_miner.yaml -p NODE_ID=3
oc new-app -f ./quorum_fullnode.yaml -p NODE_ID=1
oc new-app -f ./quorum_fullnode.yaml -p NODE_ID=2

oc create -f ./quorumRpcSvc.yaml
oc new-app -f ./classic_explorer.yaml
