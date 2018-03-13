Vagrant.configure("2") do |config|
# UCP Manager Node
  config.vm.define "upc" do |upc|
    upc.vm.box = "centos/7"
    upc.vm.box_check_update = true
    upc.vm.network "private_network", ip: "192.168.168.10"
    upc.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
    end
    upc.vm.hostname = "upc-node1"
    upc.vm.provision "shell", path: "generic_setup.sh"
  end

# DTR Worker Node
  config.vm.define "dtr" do |dtr|
    dtr.vm.box = "centos/7"
    dtr.vm.box_check_update = true
    dtr.vm.network "private_network", ip: "192.168.168.20"
    dtr.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
    end
    dtr.vm.hostname = "dtr-node1"
    dtr.vm.provision "shell", path: "generic_setup.sh"
  end

# Worker Node 01
  config.vm.define "worker1" do |worker1|
    worker1.vm.box = "centos/7"
    worker1.vm.box_check_update = true
    worker1.vm.network "private_network", ip: "192.168.168.30"
    worker1.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    worker1.vm.hostname = "worker-node1"
    worker1.vm.provision "shell", path: "generic_setup.sh"
  end

# Worker Node 02
  config.vm.define "worker2" do |worker2|
    worker2.vm.box = "centos/7"
    worker2.vm.box_check_update = true
    worker2.vm.network "private_network", ip: "192.168.168.31"
    worker2.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    worker2.vm.hostname = "worker-node2"
    worker2.vm.provision "shell", path: "generic_setup.sh"
  end

# HAProxy Load Balancer
  config.vm.define "haproxy" do |haproxy|
    haproxy.vm.box = "centos/7"
    haproxy.vm.box_check_update = true
    haproxy.vm.network :forwarded_port, guest: 9000, host: 8000
    haproxy.vm.network :forwarded_port, guest: 80, host: 8080
    haproxy.vm.network "private_network", ip: "192.168.168.2"
    haproxy.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
    end
    haproxy.vm.hostname = "haproxy-node1"
    #haproxy.vm.provision :shell, :path => "haproxy-setup.sh"
    haproxy.vm.provision :shell, :path => "file1.sh"
    haproxy.vm.provision :shell, :path => "file2.sh"
  end

end
