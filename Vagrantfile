# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

  require_relative 'lib/better_usb.rb'
  require_relative 'lib/os_detector.rb'

  if ARGV[0] == "up" then
    has_installed_plugins = false
      
    unless Vagrant.has_plugin?("vagrant-vbguest")
      system("vagrant plugin install vagrant-vbguest")
      has_installed_plugins = true
    end

  if has_installed_plugins then
    puts "Vagrant plugins were installed. Please run vagrant up again to install the VM"
    exit
  end
end

Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty32"
  config.vm.hostname = "stm32-dev"
  # Setup rule to automatically attach ST Link v2.1 Debugger when plugging in Nucleo board
  config.vm.provider :virtualbox do |vb|
# vb.customize ['modifyvm', :id, '--usb', 'on']
#    vb.customize ['modifyvm', :id, '--usbehci', 'on']
 
    vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'STLink', '--vendorid', '0x0483', '--productid', '0x3748']
    
    # Enable sharing the clipboard
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]

    BetterUSB.usbfilter_add(vb, "0x0483", "0x374b", "ST Link v2.1 Nucleo")  
  end


  config.vm.provision :shell, path: "bootstrap.sh"


end
