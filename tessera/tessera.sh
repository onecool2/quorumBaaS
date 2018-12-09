cp -r /shareStorage/node${NODE_ID}/tessera ~/tessera
echo "127.0.0.1 ${TESSERASERVICENAME}" >> /etc/hosts
sed -i 's/TESSERA_PORT/'${TESSERA_PORT}'/g' ~/tessera/tessera-config.json
sed -i 's/TESSERASERVICENAME/'${TESSERASERVICENAME}'/g' ~/tessera/tessera-config.json
#wait 3s for update hostname work
sleep 3
java $DEBUG $MEMORY $LAUNCH_TESSERA_PARAMETERS -configfile ~/tessera/tessera-config.json
