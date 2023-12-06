# Get docker from github
git clone https://github.com/manojpramesh/ethereum-docker.git

# Start ethereum nodes
cd ethereum-docker
sudo docker compose -f docker-compose-standalone.yml up -d
sudo docker compose up -d
sudo docker exec -it ethereum-docker-geth-1 geth attach ipc://root/.ethereum/devchain/geth.ipc
cd ..

# Show status
sudo docker ps


docker build -t ganache .
docker run -p 8545:8545 -d --name ganache ganache
docker ps
