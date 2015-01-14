#
# Cookbook Name:: nginx-example
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
node.default['nginx']['source']['version'] = "1.6.2"
node.default['nginx']['source']['url'] = 'http://nginx.org/download/nginx-1.6.2.tar.gz'
node.default['nginx']['source']['checksum'] = 'b5608c2959d3e7ad09b20fc8f9e5bd4bc87b3bc8ba5936a513c04ed8f1391a18' 
node.default['nginx']['default_site_enabled'] = false
node.default['nginx']['default_root'] = '/var/www/example'

include_recipe "nginx::source"

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
