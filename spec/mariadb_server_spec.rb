require_relative 'spec_helper'

describe 'fivem::mariadb_server' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.override['fivem']['mariadb']['version'] = '10.1'
      node.override['fivem']['mariadb']['server']['host'] = '0.0.0.0'
      node.override['fivem']['mariadb']['server']['port'] = 3307
      node.override['fivem']['mariadb']['server']['password'] = 'specpass'
    end.converge(described_recipe)
  end

  it 'installs mariadb_server_install[FiveM MariaDB Server]' do
    expect(subject).to install_mariadb_server_install('FiveM MariaDB Server')
      .with(setup_repo: true,
            version: '10.1',
            password: 'specpass')
  end

  it 'creates mariadb_server_install[FiveM MariaDB Server]' do
    expect(subject).to create_mariadb_server_install('FiveM MariaDB Server')
      .with(setup_repo: true,
            version: '10.1',
            password: 'specpass')
  end

  it 'modifies mariadb_server_configuration[FiveM MariaDB Server Configuration]' do
    expect(subject).to modify_mariadb_server_configuration('FiveM MariaDB Server Configuration')
      .with(version: '10.1',
            mysqld_bind_address: '0.0.0.0',
            mysqld_port: 3307)
  end
end
