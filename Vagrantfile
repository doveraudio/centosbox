# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  # Change this line to forward ports from this machine directly to localhost,
  # http://192.168.33.10:80 will be mirrored by http://localhost:8080
  # config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "private_network", ip: "192.168.33.10"

  # config.vm.network "public_network"
    config.vm.synced_folder "./data", "/var/data", :mount_options => ["dmode=777", "fmode=666"], type: "virtualbox"
  #  config.vm.synced_folder ".", "/home/vagrant/sync", type: "virtualbox" 
     config.vm.synced_folder ".", "/vagrant", type: "virtualbox" 
  #  config.vm.synced_folder ".", "/vagrant", disabled: true
  # Virtualbox configuring:
    config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #    vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
      vb.memory = "2048"
    end
  #
    config.vm.provision "shell", path: "./data/provision.sh", name: "centos/7"
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
