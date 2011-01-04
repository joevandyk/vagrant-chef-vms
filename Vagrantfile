# These .pub files get copied to your VM's authorized_keys file
# letting you login to the VM w/o passwords 
# (as the monkey user)
your_ssh_public_key = []
Dir[File.expand_path("~/.ssh") + "/*.pub"].each do |file|
  your_ssh_public_key << File.read(file)
end

Vagrant::Config.run do |config|
  # Use lucid32 as the base box
  config.vm.box = "lucid32"
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"
  
  # Use chef-solo for setting VMs up
  config.vm.provisioner = :chef_solo

  # Tell chef to use verbose logging and where the files are
  config.chef.log_level = :debug
  config.chef.cookbooks_path = "cookbooks"
  config.chef.roles_path = "roles"
  
  # We use the 'monkey' user as the main user
  config.chef.json.merge!({:users => { :monkey => { :ssh_authorized_keys => your_ssh_public_key } } } )
  config.chef.json.merge!({:main_user => :monkey})

  # Connect to the apt cacheer vm for downloading deb packages
  config.chef.json.merge!({:apt_cache => "http://33.33.33.2:3142"})

  # Setup a VM that's just used for caching apt packages
  config.vm.define :apt_cacher do |c|
    c.vm.customize { |vm| vm.name = "apt-cacher" }
    c.vm.network "33.33.33.2"
    c.chef.add_recipe "apt-cacher-ng-server"
    c.chef.json.merge!({:apt_cache => false })
  end

  # Setup a VM used for haskell development
  config.vm.define :haskell do |c|
    c.vm.customize { |vm| vm.name = "haskell" }
    c.vm.network "33.33.33.10"
    c.chef.add_recipe "base"
    c.chef.add_recipe "haskell"
  end

  # Setup a VM used for scala development
  config.vm.define :scala do |c|
    c.vm.customize { |vm| vm.name = "scala" }
    c.vm.network "33.33.33.11"
    c.chef.add_recipe "base"
    c.chef.add_recipe "scala"
  end
end
