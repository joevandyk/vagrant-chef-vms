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
  config.vm.box_url = "https://s3.amazonaws.com/tanga/lucid32.box"

  # Use chef-solo for setting VMs up
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug
    chef.cookbooks_path = ["common_cookbooks", "cookbooks"]
    chef.roles_path = "roles"
    chef.json.merge!({:users => { :monkey => { :ssh_authorized_keys => your_ssh_public_key } } } )
    chef.json.merge!({:main_user => :monkey})
    chef.json.merge!({:node_hostname => "scratch1.dev"})
    chef.add_recipe "base"
    chef.add_recipe "graphite"
    chef.add_recipe "node_coffee"

    # Connect to the apt cacheer vm for downloading deb packages
    #chef.json.merge!({:apt_cache => "http://33.33.33.2:3142"})

    # Setup a VM that's just used for caching apt packages
=begin
    config.vm.define :apt_cacher do |c|
      c.vm.customize { |vm| vm.name = "apt-cacher" }
      c.vm.network "33.33.33.2"
      chef.add_recipe "apt-cacher-ng-server"
      chef.json.merge!({:apt_cache => false })
    end

    # Setup a VM used for haskell development
    config.vm.define :haskell do |c|
      c.vm.customize { |vm| vm.name = "haskell" }
      c.vm.network "33.33.33.10"
      chef.add_recipe "base"
      chef.add_recipe "haskell"
    end

    # Setup a VM used for scala development
    config.vm.define :scala do |c|
      c.vm.customize { |vm| vm.name = "scala" }
      c.vm.network "33.33.33.11"
      chef.add_recipe "base"
      chef.add_recipe "scala"
    end
=end

    # Setup a VM used for random development
    config.vm.define :scratch do |c|
      c.vm.customize { |vm| vm.name = "scratch" }
      c.vm.network "33.33.33.12"
      chef.add_recipe "base"
      chef.add_recipe "graphite"
    end
  end
end
