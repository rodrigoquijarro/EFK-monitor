#!/bin/bash
# Loading Docker Images for: Fluentd:custom-fluentd.tar | Elasticsearch:elasticsearch.tar | Kibana:kibana.tar
cd td-agent-server
sudo dpkg -i td-agent_3.7.1-0_amd64.deb
echo ">>> TD-Agent Server installation complete, applying configuration to connect EFK-Stack Server..."
sudo cp td-agent.conf /etc/td-agent/
echo ">>> TD-Agent-EFK Server configuration applied!"
echo ">>> Restarting TD-Agent Server EFK services..."
sudo systemctl stop td-agent.service
sudo systemctl start td-agent.service
echo "  >>> TD-AGENT SERVER INSTALLED."
echo ">>> 1. Reading Fluentd-Elastiseach-Kibana custom Docker images..."
cd ..
sudo chmod -R 775 fluentd
cd EFK_Images
echo ">>> 2. Loading EFK-Stack images..."
docker load --input custom-fluentd.tar
docker load --input elasticsearch.tar
docker load --input kibana.tar
echo ">>> EFK-Stack Docker images loaded."
echo ">>> 3. Starting Schneider EFK-Stack Docker-compose integration..."
docker-compose up -d
echo ">>> EFK-Stack Docker-compose deployed."
echo ">>> Please proceed with: "
echo "    a) Elasticsearch ca certificates configuration."
echo "    b) Elasticsearch setup passwords configuration."
echo "    c) Fluentd config file parameters --> (custom-fluentd/fluentd.conf)."
