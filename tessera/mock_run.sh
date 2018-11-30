rm -rf ./shareStorage
mkdir ./shareStorage/ -p
cp -r ./oriShareStorage/* ./shareStorage/  

docker run -it --rm -e TESSERADIR="\/root\/tessera" -e DDIR="\/tesserasocket" -e TESSERASERVCIENAME="localhost" -e TESSERA_PORT=9000 -e MEMORY="-Xms128M -Xmx128M" -e LAUNCH_TESSERA_PARAMETERS="-jar /tessera/tessera-app.jar" -e NODE_ID=0 -v /home/alex/GOPATH/src/github.com/quorumBaaS/tessera/shareStorage:/shareStorage tessera 
