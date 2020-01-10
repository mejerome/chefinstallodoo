#
# Cookbook:: odoo
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

# Update Server
apt_update 'Update'

# Add Odoo package repo
apt_repository 'odoo' do
  uri 'http://nightly.odoo.com/11.0/nightly/deb'
  components ['odoo']
  action :add
  key 'https://nightly.odoo.com/odoo.key'
  notifies :run, 'apt_update[update-odoo]', :immediately
end

apt_update 'update-odoo' do
  ignore_failure true
  action :nothing
end

# Install Postgresql Server
postgresql_server_install 'My PostgreSQL Server install' do
  action :install
end

service 'postgresql' do
  action [:enable, :start]
end

# Setup Postgresql Server
postgresql_server_install 'Setup my PostgreSQL 9.6 server' do
  password 'odoo'
  action :create
end

