
Vagrant.configure("2") do | config |
vmnumber = 2
   config.vm.define "master" do |master|
    master.vm.box = "debian/bullseye64"
    master.vm.hostname = "master"
    master.vm.network :private_network, ip:"192.168.56.20"
    master.vm.provision "shell", inline: <<-SHELL
    apt update
    apt install docker.io -y
    sudo adduser vagrant docker
    docker swarm init --advertise-addr 192.168.56.20
    docker swarm join-token worker -q > /vagrant/swarm_token.txt
    docker build -t api /vagrant   
   SHELL
  end


 (1.. vmnumber).each do | i |
  config.vm.define "worker#{i}" do | worker |
   worker.vm.box = "debian/bullseye64"
   worker.vm.hostname = "worker#{i}"
   worker.vm.network :private_network, ip:"192.168.56.2#{i}"
   worker.vm.provision "shell", inline: <<-SHELL
    apt update
    apt install docker.io -y
    sudo adduser vagrant docker
    docker swarm join --token `cat /vagrant/swarm_token.txt` 192.168.56.20:2377
    docker build -t api /vagrant
   SHELL
  end
 end

end
