# -*- mode: ruby -*-
# vi: set ft=ruby :

# I borrowed this file from https://github.com/UtahDave/salt-vagrant-demo.git
# This helped fill a need to test salt-ssh since Docker doesn't easily run 
# daemons with systemctl. The synced folders and other setup files were 
# removed since the default CentOS 7 Vagrant box through Virtualbox does
# not have the drivers installed for doing that stuff and I didn't want to 
# take the time to fix that for myself.
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  os = "centos/7"
  net_ip = "192.168.70"
  salt_version = "v2016.11.7"

  config.vm.define :master, primary: true do |master_config|
    master_config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 1
        vb.name = "master"
    end
      master_config.vm.box = "#{os}"
      master_config.vm.host_name = 'saltmaster.local'
      master_config.vm.network "private_network", ip: "#{net_ip}.10"
    #   master_config.vm.synced_folder "saltstack/salt/", "/srv/salt"
    #   master_config.vm.synced_folder "saltstack/pillar/", "/srv/pillar"

      master_config.vm.provision :salt do |salt|
        # salt.master_config = "saltstack/etc/master"
        # salt.master_key = "saltstack/keys/master_minion.pem"
        # salt.master_pub = "saltstack/keys/master_minion.pub"
        # salt.minion_key = "saltstack/keys/master_minion.pem"
        # salt.minion_pub = "saltstack/keys/master_minion.pub"
        # salt.seed_master = {
        #                     "minion1" => "saltstack/keys/minion1.pub",
        #                     "minion2" => "saltstack/keys/minion2.pub"
        #                    }

        salt.install_type = "git"
        salt.install_args = "#{salt_version}"
        salt.install_master = true
        salt.no_minion = true
        salt.verbose = true
        salt.colorize = true
        salt.bootstrap_options = "-P -c /tmp"
      end
    end


    [
      ["minion1",    "#{net_ip}.11",    "1024",    os ],
      ["minion2",    "#{net_ip}.12",    "1024",    os ],
    ].each do |vmname,ip,mem,os|
      config.vm.define "#{vmname}" do |minion_config|
        minion_config.vm.provider "virtualbox" do |vb|
            vb.memory = "#{mem}"
            vb.cpus = 1
            vb.name = "#{vmname}"
        end
        minion_config.vm.box = "#{os}"
        minion_config.vm.hostname = "#{vmname}"
        minion_config.vm.network "private_network", ip: "#{ip}"

        minion_config.vm.provision :salt do |salt|
        #   salt.minion_config = "saltstack/etc/#{vmname}"
        #   salt.minion_key = "saltstack/keys/#{vmname}.pem"
        #   salt.minion_pub = "saltstack/keys/#{vmname}.pub"
          salt.install_type = "git"
          salt.install_args = "#{salt_version}"
          salt.verbose = true
          salt.colorize = true
          salt.bootstrap_options = "-P -c /tmp"
        end
      end
    end
  end
