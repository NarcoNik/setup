version: '3'

services:
  #
  # Ethereum mainnet geth
  #
  # https://hub.docker.com/r/ethereum/client-go
  # https://githwcat ub.com/Capgemini-AIE/ethereum-docker/blob/master/docker-compose-standalone.yml
  #

  # Primary Ethereum instance
  ethereum:
    image: ethereum/client-go:v1.10.23
    restart: always
    container_name: ethereum
    network_mode: host
    command: >
      --http --graphql --graphql.vhosts=* --http.addr 127.0.0.1 --port 30303 --http.port 8545 --http.vhosts=* --authrpc.jwtsecret=/jwtsecret
      --authrpc.port 8551 --authrpc.addr=0.0.0.0 --authrpc.vhosts=localhost -cache 8000 --txlookuplimit 0 --syncmode snap
    volumes:
      - ./data/ethereum:/root/.ethereum
      # ETH2 beacon chain node secret file for AuthRPC.
      # Share with your beacon client.
      # Generate this file: openssl rand -hex 32 > jwtsecret
      # and share to beacon chain node.
      - ./jwtsecret:/jwtsecret

  # Beacon chain node using Lighthouse.
  # This node does not publicly expose any RPC servers
  # and only connects to above nodes using authrpc.
  lighthouse:
    container_name: lighthouse
    image: sigp/lighthouse:v3.1.0
    restart: always

    command: >
      lighthouse
       --network
       mainnet
       beacon
       --http
       --http-address=0.0.0.0
       --http-port=5052
       --execution-endpoint=http://localhost:8552
       --execution-jwt=/jwtsecret
       --checkpoint-sync-url=$INFURA_URL
    environment:
      # Do a full backtrace when lighthouse crashes
      - RUST_BACKTRACE=full
    volumes:
      - ./data/lighthouse:/root/.lighthouse
      - ./jwtsecret:/jwtsecret
