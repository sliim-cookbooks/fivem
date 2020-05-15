require_relative 'spec_helper'

describe 'fivem::vrp' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.override['fivem']['prefix'] = '/server'
      node.override['fivem']['vrp']['repository'] = 'https://my/host/vrp.git'
      node.override['fivem']['vrp']['reference'] = 'dev'
      node.override['fivem']['mariadb']['version'] = '10.1'
    end.converge(described_recipe)
  end

  it 'installs package[libmariadbclient-dev-compat]' do
    expect(subject).to install_package('libmariadbclient-dev-compat')
  end

  it 'installs package[gnupg]' do
    expect(subject).to install_package('gnupg')
  end

  it 'installs mariadb_client_install[FiveM MariaDB Client]' do
    expect(subject).to install_mariadb_client_install('FiveM MariaDB Client')
      .with(version: '10.1')
  end

  it 'installs gem_package[mysql2]' do
    expect(subject).to install_gem_package('mysql2').with(version: '0.4.9')
  end

  it 'creates mariadb_database[vrp]' do
    expect(subject).to create_mariadb_database('vrp')
      .with(host: '127.0.0.1',
            user: 'root')
  end

  it 'creates mariadb_user[vrp]' do
    expect(subject).to create_mariadb_user('vrp')
      .with(password: 'vrp',
            database_name: 'vrp',
            privileges: [:all],
            host: '%')
  end

  it 'grants mariadb_user[vrp]' do
    expect(subject).to grant_mariadb_user('vrp')
      .with(password: 'vrp',
            database_name: 'vrp',
            privileges: [:all],
            host: '%')
  end

  it 'syncs git[/server/fivem/vrp]' do
    expect(subject).to sync_git('/server/fivem/vrp')
      .with(repository: 'https://my/host/vrp.git',
            reference: 'dev')
  end

  it 'creates link[/server/fivem/server-data/resources/vrp]' do
    expect(subject).to create_link('/server/fivem/server-data/resources/vrp')
      .with(to: '/server/fivem/vrp/vrp')
  end

  it 'creates link[/server/fivem/server-data/resources/vrp_mysql]' do
    expect(subject).to create_link('/server/fivem/server-data/resources/vrp_mysql')
      .with(to: '/server/fivem/vrp/vrp_mysql')
  end
end
