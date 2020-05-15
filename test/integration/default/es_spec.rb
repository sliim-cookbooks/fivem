describe package 'unzip' do
  it { should be_installed }
end

describe file '/opt/fivem/essentialmode/essentialmode-master' do
  it { should be_directory }
end

describe file '/opt/fivem/essentialmode/es_admin-master' do
  it { should be_directory }
end

describe file '/opt/fivem/server-data/resources/essentialmode' do
  it { should be_linked_to '/opt/fivem/essentialmode/essentialmode-master' }
end

describe file '/opt/fivem/server-data/resources/es_admin' do
  it { should be_linked_to '/opt/fivem/essentialmode/es_admin-master' }
end
