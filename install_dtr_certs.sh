#!/bin/bash

# INSTALL DTR CERTS - ONLY RUN AFTER DTR IS INSTALLED
sudo curl -k https://dtr.local/ca -o /etc/pki/ca-trust/source/anchors/dtr.local.crt
sudo update-ca-trust
sudo systemctl restart docker
