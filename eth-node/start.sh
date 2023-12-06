docker images -a
docker service rm ethereum-node
sudo systemctl daemon-reload

docker compose down --rmi=all --volumes --remove-orphans
docker rmi $(docker images -a -q)
