describe file '/opt/fivem/server' do
  it { should be_directory }
end

describe file '/opt/fivem/server/run.sh' do
  it { should be_file }
  it { should be_executable }
end

describe file '/opt/fivem/server-data/.git' do
  it { should be_directory }
end

describe file '/opt/fivem/server.cfg' do
  it { should be_file }
end

describe file '/opt/fivem/start-server.sh' do
  it { should be_file }
  it { should be_executable }
end
