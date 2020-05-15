describe file '/opt/fivem/mysql-async/.git' do
  it { should be_directory }
end

describe file '/opt/fivem/server-data/resources/mysql-async' do
  it { should be_linked_to '/opt/fivem/mysql-async' }
end
