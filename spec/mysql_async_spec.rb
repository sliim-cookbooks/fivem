require_relative 'spec_helper'

describe 'fivem::mysql_async' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.override['fivem']['prefix'] = '/server'
      node.override['fivem']['mysql_async']['repository'] = 'https://my/host/mysql-async.git'
      node.override['fivem']['mysql_async']['reference'] = 'dev'
    end.converge(described_recipe)
  end

  it 'syncs git[/server/fivem/mysql-async]' do
    expect(subject).to sync_git('/server/fivem/mysql-async')
      .with(repository: 'https://my/host/mysql-async.git',
            reference: 'dev')
  end

  it 'creates link[/server/fivem/server-data/resources/mysql-async]' do
    expect(subject).to create_link('/server/fivem/server-data/resources/mysql-async')
      .with(to: '/server/fivem/mysql-async')
  end
end
