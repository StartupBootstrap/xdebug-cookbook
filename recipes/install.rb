#
# Cookbook Name:: xdebug
# Recipe:: install
#
# Copyright (C) 2014 Startup Bootstrap
#
# MIT
#

name = 'xdebug'
directives = node['xdebug']['directives']

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
  ignore_failure true
end

php_pear name do
  zend_extensions ['xdebug.so']
  directives (directives)
  action :install
end

template "#{node['php']['ext_conf_dir']}/#{name}.ini" do
  source 'extension.ini.erb'
  cookbook 'php'
  owner 'root'
  group 'root'
  mode '0644'
  variables(:name => name, :extensions =>  {'xdebug.so' => 'zend'}, :directives => directives)
  notifies :run, 'execute[enable xdebug module]'
  notifies :reload, 'service[php-fpm]' unless resource_not_found['service[php-fpm]']
  notifies :reload, 'service[apache2]' unless resource_not_found['service[apache2]']
end

execute 'enable xdebug module' do
  command 'php5enmod xdebug'
  action :nothing
  notifies :reload, 'service[php-fpm]' unless resource_not_found['service[php-fpm]']
  notifies :reload, 'service[apache2]' unless resource_not_found['service[apache2]']
end
