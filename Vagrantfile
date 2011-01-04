# vim: set filetype=ruby

your_ssh_public_key = []
Dir[File.expand_path("~/.ssh") + "/*.pub"].each do |file|
  your_ssh_public_key << File.read(file)
end

Vagrant::Config.run do |config|
  config.vm.box = "lucid32"
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"
  config.chef.log_level = :debug
  config.chef.cookbooks_path = "cookbooks"
  config.chef.roles_path = "roles"
  config.vm.provisioner = :chef_solo
  config.chef.json.merge!({:users => { :monkey => { :ssh_authorized_keys => your_ssh_public_key } } } )
  config.chef.json.merge!({:main_user => :monkey})
  config.chef.add_recipe "base"

  config.vm.define :haskell do |h|
    h.vm.network "33.33.33.10"
    h.vm.customize do |vm|
      vm.name = "haskell"
    end
    h.chef.add_recipe "haskell"
  end
end
