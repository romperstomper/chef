Vagrant::Config.run do |config|
  # VM will be based on Ubuntu 12.04 (64 bit)
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Configure the Chef Solo provisioner
  config.vm.provision :chef_solo do |chef|
    # Tell Vagrant where the cookbooks are located
    chef.cookbooks_path = "cookbooks"
    # Add recipes to be executed in given order
    chef.add_recipe "apt"          # Shortcut for apt::default
    chef.add_recipe "git::source"  # Will include build-essential::default
  end
end
