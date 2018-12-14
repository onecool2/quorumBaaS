if [ x$nodeNumber != x ] ; then
   number=$nodeNumber
else
   number=3
fi

if [ x$password = x ] ; then
   password="abc"
fi
shareStorage="/shareStorage"  ###need to be changed in real environment
rm -rf ${shareStorage}/*
echo $password > ./password
echo $password > ./tessera_password
declare -i N
rm -rf ${shareStorage}/permissioned-nodes.json
mkdir -p ${shareStorage}
#generate tessera-config.json
cp  /etc/tessera-config.json ${shareStorage}/tessera-config.json ###need to be changed in real environment
for((n=1; n<=number; n++ ));
do
   echo "        ," >> ${shareStorage}/tessera-config.json
   echo "        {" >> ${shareStorage}/tessera-config.json
   echo "            \"url\": \"http://tessera-service${n}:9000\"" >> ${shareStorage}/tessera-config.json
   echo "        }" >> ${shareStorage}/tessera-config.json
done

echo "    ]" >> ${shareStorage}/tessera-config.json
echo "}" >> ${shareStorage}/tessera-config.json
echo  "[" >> ${shareStorage}/permissioned-nodes.json
for((n=0; n <=number; n++ ));
do
   echo $n
   #quorum configration
   mkdir -p ${shareStorage}/node${n}/quorum/geth
   #newAccount=`geth --datadir ${shareStorage}/node${n} account new --password ./password`
   #accountList=`echo $newAccount | awk -F '{' '{print $2}'|awk -F '}' '{print $1}'`
   if [ -n "$accountList" ]; then
        accountList+=','
   fi
   newAccount=`geth --datadir ${shareStorage}/node${n}/quorum account new --password ./password`
   coinbase=`echo $newAccount | awk -F '{' '{print $2}'|awk -F '}' '{print $1}'`
   if [ "${n}" -gt 0 ]; then
        accountList+=${coinbase}
   fi 
   echo ${coinbase} >${shareStorage}/node${n}/quorum/coinbase 

   bootnode -genkey ${shareStorage}/node${n}/quorum/geth/nodekey
   nodekey=`bootnode -nodekey ${shareStorage}/node${n}/quorum/geth/nodekey -writeaddress`

   # remove the latest ',' for json rule
   N=$number
   if [ "$n" -lt "$N" ]; then
       echo \"enode://${nodekey}@quorum-p2p-service${n}:21000?discport=0\"\, >> ${shareStorage}/permissioned-nodes.json
   else
       echo \"enode://${nodekey}@quorum-p2p-service${n}:21000?discport=0\" >> ${shareStorage}/permissioned-nodes.json
   fi
   #tessera configration
   java -jar /usr/local/bin/tessera-app-0.7.3-app.jar -keygen -filename tm
   mkdir -p ${shareStorage}/node${n}/tessera
   mv tm.* ${shareStorage}/node${n}/tessera
   cp  ${shareStorage}/tessera-config.json ${shareStorage}/node${n}/tessera
   sed -i 's/PASSWORD/'$password'/g' ${shareStorage}/node${n}/tessera/tessera-config.json

done

echo  "]" >> ${shareStorage}/permissioned-nodes.json
#  puppeth  >> genesis.json
echo puppeth --newgenesis 1 --network=genesis --consensys poa --period 5 --networkID 5 --sealaccount ${accountList} --prefundedaccount ${accountList}
puppeth --newgenesis 1 --network=genesis --consensys poa --period 5 --networkID 5 --sealaccount ${accountList} --prefundedaccount ${accountList}
mv genesis.json ${shareStorage}/clique-genesis.json
for((n=0; n<=number; n++ ));
do
   #geth --datadir ${shareStorage}/node${n}/quorum init ${shareStorage}/genesis.json
   cp ${shareStorage}/permissioned-nodes.json ${shareStorage}/node${n}/quorum/static-nodes.json 
   cp ${shareStorage}/permissioned-nodes.json ${shareStorage}/node${n}/quorum/permissioned-nodes.json 
   if [ "${n}" -gt 0 ]; then
      cp ./password ${shareStorage}/node${n}/quorum/password
   fi 
done
rm -rf ./password
