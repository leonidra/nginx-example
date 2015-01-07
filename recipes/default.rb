#
# Cookbook Name:: nginx-example
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "nginx"

node.default['nginx']['default_site_enabled'] = false
node.default['nginx']['default_root'] = '/var/www/example'

template "#{node['nginx']['dir']}/sites-available/example" do
  source 'example-site.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  notifies :reload, 'service[nginx]'
end

directory "#{node['nginx']['default_root']}" do
  owner node['nginx']['user']
  action :create
  recursive true
end

file "#{node['nginx']['default_root']}/index.html" do
  content "<html><body><h1>Hello from Chef</h1></body></html>"
end

nginx_site 'example' do
  enable true
end
