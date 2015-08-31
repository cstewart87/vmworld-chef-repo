#
# Cookbook Name:: hello_vmworld
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'httpd' do
	action :install
end

file '/var/www/html/index.html' do
	content "Hello VMworld, from #{node['hostname']} @ #{node['ipaddress']}!"
	action :create
end

service 'httpd' do
	action [:enable, :start]
end

service 'iptables' do
	action :stop
end
