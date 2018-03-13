# INSTALL UCP
export UCP_IPADDR=$(cat /vagrant/config/centos-ucp-node1)
export UCP_PASSWORD=$(cat /vagrant/config/ucp_password)
docker run --rm --name ucp -v /var/run/docker.sock:/var/run/docker.sock docker/ucp:2.2.5 install --host-address ${UCP_IPADDR} --admin-password ${UCP_PASSWORD} --san ucp.local --license $(cat /vagrant/docker_subscription.lic) --debug

# Generate UCP ID
docker run --rm --name ucp -v /var/run/docker.sock:/var/run/docker.sock docker/ucp:2.2.5 id | awk '{ print $1}' > /vagrant/config/centos-ucp-id
export UCP_ID=$(cat /vagrant/config/centos-ucp-id)
echo $UCP_ID

# BKP UCP
docker run --log-driver none --rm -i --name ucp -v /var/run/docker.sock:/var/run/docker.sock docker/ucp:2.2.5 backup --id ${UCP_ID} --root-ca-only --passphrase "secret" > /vagrant/backup_upc_20180305.tar

# ADD MANAGER UCP NODES
# docker swarm join --token SWMTKN-1-007wyt9h0lkw8s8d8h3m17zwige174qqpnf5lrz02vawkzdcy2-edoz7wzt4030302djff4jm42n 192.168.168.10:2377

# INSTALL DTR CERTS - ONLY RUN AFTER DTR IS INSTALLED
#sudo curl -k https://dtr.local/ca -o /etc/pki/ca-trust/source/anchors/dtr.local.crt
#sudo update-ca-trust
#sudo systemctl restart docker
