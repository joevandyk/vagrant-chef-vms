
%w(ssh
   sudo
   users
   apt
   bash-vim
   ppa
   ruby_enterprise
).each do |recipe_name|
    include_recipe recipe_name
end


%w(vim
   man-db
   libxml2-dev
   libxslt1-dev
   build-essential
   git-core
   libmagick++-dev
   libcurl4-openssl-dev
   command-not-found
   htop
   sysstat
).each do |name|
  package name
end

gems = {
  "bundler"   => "1.0.7",
  "rake"      => "0.8.7",
}

gems.each do |gem, v|
  ree_gem gem do
    action :install
    version v
  end
end
