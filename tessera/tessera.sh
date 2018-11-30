mv /shareStorage/node${NODE_ID}/tessera ~/tessera
sed -i 's/TESSERA_PORT/'${TESSERA_PORT}'/g' ~/tessera/tessera-config.json
sed -i 's/TESSERASERVCIENAME/'${TESSERASERVCIENAME}'/g' ~/tessera/tessera-config.json
sed -i 's/DDIR/'${DDIR}'/g' ~/tessera/tessera-config.json
sed -i 's/TESSERADIR/'${TESSERADIR}'/g' ~/tessera/tessera-config.json
java $DEBUG $MEMORY $LAUNCH_TESSERA_PARAMETERS -configfile ~/tessera/tessera-config.json
