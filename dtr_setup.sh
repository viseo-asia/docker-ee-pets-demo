# SETUP DTR
< /dev/urandom tr -dc a-f0-9 | head -c${1:-12} > /vagrant/config/dtr-replica-id
export UCP_IPADDR=192.168.168.10
export DTR_IPADDR=$(cat /vagrant/config/centos-dtr-node1)
export UCP_PASSWORD=$(cat /vagrant/config/ucp_password)
export DTR_REPLICA_ID=$(cat /vagrant/config/dtr-replica-id)
echo "192.168.168.10  ucp.local" >> /etc/hosts

# INSTALL DTR
docker run --rm docker/dtr:2.4.2 install --ucp-url https://${UCP_IPADDR} --ucp-node dtr-node1 --replica-id ${DTR_REPLICA_ID} --dtr-external-url https://dtr.local --ucp-username admin --ucp-password ${UCP_PASSWORD} --ucp-ca "$(cat ucp-ca.pem)"

# BACKUP DTR
docker run --rm docker/dtr:2.4.2 backup --ucp-url https://${UCP_IPADDR} --existing-replica-id ${DTR_REPLICA_ID} --ucp-username admin --ucp-password ${UCP_PASSWORD} --ucp-ca "$(cat ucp-ca.pem)" > /tmp/backup-dtr-20180306.tar

# INSTALL DTR CERTS
sudo curl -k https://dtr.local/ca -o /etc/pki/ca-trust/source/anchors/dtr.local.crt
sudo update-ca-trust
sudo systemctl restart docker
