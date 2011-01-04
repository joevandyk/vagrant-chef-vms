include_recipe "ppa"

add_ubuntu_ppa "ppa:justinbogner/haskell-platform" do
    provides_package "haskell-platform"
end

package "haskell-platform"
