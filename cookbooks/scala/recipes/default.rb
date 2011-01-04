include_recipe "ppa"

add_ubuntu_ppa "ppa:bneijt/ppa" do
  provides_package "scala"
end

package "scala"
