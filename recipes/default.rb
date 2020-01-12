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

# Run apt update
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

# Install Python Dependencies
package 'python3-pip' do
  action :install
end

# Install requirement for pip-psycopg2
package 'libpq-dev' do
  action :install
end

# Install Pip Packages
%w(Babel decorator docutils ebaysdk feedparser gevent greenlet html2text Jinja2 lxml Mako MarkupSafe mock num2words ofxparse passlib Pillow psutil psycogreen psycopg2 pydot pyparsing PyPDF2 pyserial python-dateutil python-openid pytz pyusb PyYAML qrcode reportlab requests six suds-jurko vatnumber vobject Werkzeug XlsxWriter xlwt xlrd).each do |package|
  execute "pip3 install #{package}" do
    command "pip3 install #{package}"
    action :run
  end
end

# Install npm
package 'npm' do
  action :install
end

# Create Symbolic link for nodejs
execute 'ln nodejs' do
  command 'sudo ln -s /usr/bin/nodejs /usr/bin/node'
  action :run
end
