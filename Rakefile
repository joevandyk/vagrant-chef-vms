begin
  require 'rubygems'
  require 'bundler/setup'
  require 'vagrant'
rescue LoadError => e
  STDERR.puts "You install bundler yet?"
  puts e.message
  exit -1
end

task :bundler do
  if !File.exist?("vendor/bundler")
    sh "bundle install --path=vendor/bundler --binstubs"
  else
    sh "bundle install --local --path=vendor/bundler --binstubs"
  end
end

task :start_vm => :bundler do
  sh "./bin/vagrant up"
end

task :update_vm => [:bundler] do
  sh "./bin/vagrant provision"
end

task :recreate_vm => [:bundler] do
  sh "./bin/vagrant destroy"
  Rake::Task[:start_vm].invoke
end

