%w(ssh
   sudo
   users
   apt
   ppa
  ).each do |recipe_name|
    include_recipe recipe_name
end

