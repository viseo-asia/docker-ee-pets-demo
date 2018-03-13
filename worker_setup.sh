# ADD WORKER TO SWARM CLUSTER
docker swarm join --token SWMTKN-1-007wyt9h0lkw8s8d8h3m17zwige174qqpnf5lrz02vawkzdcy2-706klzmr5cqk7mp2crasvyt3b 192.168.168.10:2377

# INSTALL DTR CERTS
sudo curl -k https://dtr.local/ca -o /etc/pki/ca-trust/source/anchors/dtr.local.crt
sudo update-ca-trust
sudo systemctl restart docker
