docker build -t ganache .
docker run -p 8545:8545 -d --name ganache ganache
docker ps
