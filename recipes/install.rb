#
# Cookbook Name:: xdebug
# Recipe:: install
#
# Copyright (C) 2014 Startup Bootstrap
#
# MIT
#

resource_not_found = {}
begin
  resources('service[php-fpm]')
rescue Chef::Exceptions::ResourceNotFound
  resource_not_found['service[php-fpm]'] = true
end
begin
  resources('service[apache2]')
rescue Chef::Exceptions::ResourceNotFound
  resource_not_found['service[apache2]'] = true
end

directory 'xdebug.profiler_output_dir' do
  path node['xdebug']['directives']['profiler_output_dir']
  owner 'www-data'
  group 'www-data'
  action :create
  only_if { node['xdebug']['directives']['profiler_output_dir'] }
end

php_pear 'xdebug' do
  zend_extensions ['xdebug.so']
  directives (node['xdebug']['directives'])
  action :install
  notifies :reload, 'service[php-fpm]' unless resource_not_found['service[php-fpm]']
  notifies :reload, 'service[apache2]' unless resource_not_found['service[apache2]']
end
