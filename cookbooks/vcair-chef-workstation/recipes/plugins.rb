#
# Cookbook Name:: vcair-chef-workstation
# Recipe:: plugins
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

gem_package 'knife-vcair' do
  gem_binary('/opt/chefdk/embedded/bin/gem')
end
