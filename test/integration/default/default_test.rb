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
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port('5432') do
  it { should be_listening }
end

describe package('python3-pip') do
  it { should be_installed }
end

py_pack = %w(Babel decorator docutils ebaysdk feedparser
             gevent greenlet html2text Jinja2 lxml Mako MarkupSafe mock
             num2words ofxparse passlib Pillow psutil psycogreen psycopg2
             pydot pyparsing PyPDF2 pyserial python-dateutil python-openid
             pytz pyusb PyYAML qrcode reportlab requests six suds-jurko
             vatnumber vobject Werkzeug XlsxWriter xlwt xlrd
)
py_pack.each do |p|
  describe pip(p) do
    it { should be_installed }
  end
end
