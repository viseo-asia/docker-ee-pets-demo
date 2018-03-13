# INSTALL HAPROXY

sudo yum -y install gcc pcre-static pcre-devel wget
wget http://www.haproxy.org/download/1.7/src/haproxy-1.7.10.tar.gz -O ~/haproxy.tar.gz
tar xzvf ~/haproxy.tar.gz -C ~/
cd ~/haproxy-1.7.10/
make TARGET=linux2628
sudo make install

# SETUP HAPROXY
sudo mkdir -p /etc/haproxy
sudo mkdir -p /var/lib/haproxy
sudo touch /var/lib/haproxy/stats
sudo ln -s /usr/local/sbin/haproxy /usr/sbin/haproxy
sudo cp ~/haproxy-1.7.10/examples/haproxy.init /etc/init.d/haproxy
sudo chmod 755 /etc/init.d/haproxy
sudo systemctl daemon-reload
sudo chkconfig haproxy on
sudo useradd -r haproxy
haproxy -v

# CONFIG DOCKER EE LB
sudo sh -c "echo 'global
    log /dev/log local0
    log /dev/log local1 notice
    chroot /var/lib/haproxy
    stats timeout 30s
    user haproxy
    group haproxy
    daemon
    maxconn 256

defaults
    log global
    mode http
    option httplog
    option dontlognull
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms

frontend http_front
   bind *:80
   stats uri /haproxy?stats
   acl url_dtr path_beg dtr.local
   use_backend dtr_back if url_dtr
   acl url_upc path_beg upc.local
   use_backend upc_back if url_upc
   default_backend http_back

backend http_back
   balance roundrobin
   server worker1.local 192.168.168.31:8000 check
   server worker2.local 192.168.168.32:8000 check

backend upc_back
   server upc.node1 192.168.168.10:443 check
   server upc.node2 192.168.168.11:443 check

backend dtr_back
   server dtr.node1 192.168.168.20:443 check

listen admin
    bind *:8080
    stats enable' > /etc/haproxy/haproxy.cfg"

sudo systemctl restart haproxy

