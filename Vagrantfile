# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.provider :libvirt do |lib|
    lib.cpus   = 2
    lib.memory = 3072
  end

  config.vm.define :servidorParcial do |servidorParcial|
    servidorParcial.vm.box = "generic/ubuntu2204"
    servidorParcial.vm.hostname = "servidor"
    servidorParcial.vm.network :private_network, ip: "192.168.100.3"
    servidorParcial.vm.synced_folder "./docs", "/home/vagrant/compartida",
                              type: "nfs", nfs_version: 4
  end
end
