# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.host_name = "hhvm.vanillaforums.dev"

  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.synced_folder "./www", "/var/www",
    owner: "www-data",
    group: "www-data"

  config.vm.provision "puppet" do |puppet|
    puppet.hiera_config_path = "provision/puppet/hiera.yaml"
    puppet.manifests_path = "provision/puppet/manifests"
    puppet.manifest_file = "site.pp"
    puppet.module_path = "provision/puppet/modules"
    puppet.options = "--parser=future --verbose"
  end

  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
  end
end

