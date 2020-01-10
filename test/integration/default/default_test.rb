# InSpec test for recipe odoo::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe command('apt update') do
  its('stdout') { should match /ubuntu/ }
end

describe file('/etc/apt/sources.list.d/odoo.list') do
  it { should exist }
  its('content') { should match /odoo/ }
end

describe service('postgresql') do
  it { should be_enabled }
  it { should be_running }
end

describe port('5432') do
  it { should be_listening }
end

describe service('odoo') do
  it { should be_enabled }
  it { should be_running }
end
