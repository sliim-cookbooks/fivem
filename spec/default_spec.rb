require_relative 'spec_helper'

describe 'fivem::default' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.override['fivem']['prefix'] = '/server'
      node.override['fivem']['version'] = '2431-350dd7bd5c0176216c38625ad5b1108ead44674d'
      node.override['fivem']['server_data']['repository'] = 'https://my/host/server-data.git'
      node.override['fivem']['server_data']['reference'] = 'dev'
      node.override['fivem']['endpoints'] = {
        'tcp' => '127.0.0.1:1337',
        'udp' => '127.0.0.1:1337',
      }
      node.override['fivem']['resources'] = %w(
        mapmanager
        chat
        spawnmanager
        sessionmanager
        mycustomresource
      )
      node.override['fivem']['config'] = {
        'sets tags' => 'chef',
        'sv_hostname' => 'FiveM Spec',
        'set temp_convar' => 'running specs',
        'sv_master1' => '',
        'add_ace group.admin command' => 'allow',
        'add_ace group.admin command.quit' => 'deny',
        'add_principal identifier.steam:01234567890123456' => 'group.admin',
        'sv_endpointprivacy' => true,
        'sv_maxclients' => 10,
        'sv_licenseKey' => 'secret-key',
      }
    end.converge(described_recipe)
  end

  before do
    stub_command('test -f 2431-350dd7bd5c0176216c38625ad5b1108ead44674d-fx.tar.xz').and_return(false)
  end

  it 'creates directory[/server/fivem/server]' do
    expect(subject).to create_directory('/server/fivem/server').with(recursive: true)
  end

  it 'creates remote_file[/server/fivem/server/2431-350dd7bd5c0176216c38625ad5b1108ead44674d-fx.tar.xz]' do
    expect(subject).to create_remote_file('/server/fivem/server/2431-350dd7bd5c0176216c38625ad5b1108ead44674d-fx.tar.xz')
      .with(source: 'https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/2431-350dd7bd5c0176216c38625ad5b1108ead44674d/fx.tar.xz',
            owner: 'root',
            group: 'root',
            mode: '0644')
    expect(subject.remote_file('/server/fivem/server/2431-350dd7bd5c0176216c38625ad5b1108ead44674d-fx.tar.xz')).to notify('execute[untar-fx]').to(:run)
  end

  it 'syncs git[/server/fivem/server-data]' do
    expect(subject).to sync_git('/server/fivem/server-data')
      .with(repository: 'https://my/host/server-data.git',
            reference: 'dev')
  end

  it 'creates template[/server/fivem/server.cfg]' do
    expect(subject).to create_template('/server/fivem/server.cfg')
      .with(owner: 'root',
            group: 'root',
            mode: '0644',
            source: 'server.cfg.erb')

    [start_with('# Fivem server configuration template'),
     /^endpoint_add_tcp "127.0.0.1:1337"$/,
     /^endpoint_add_udp "127.0.0.1:1337"$/,
     /^start mapmanager$/,
     /^start chat$/,
     /^start spawnmanager$/,
     /^start sessionmanager$/,
     /^start mycustomresource$/,
     /^sets tags "chef"$/,
     /^sv_hostname "FiveM Spec"$/,
     /^set temp_convar "running specs"$/,
     /^sv_master1 ""$/,
     /^add_ace group.admin command "allow"$/,
     /^add_ace group.admin command.quit "deny"$/,
     /^add_principal identifier.steam:01234567890123456 "group.admin"$/,
     /^sv_endpointprivacy true$/,
     /^sv_maxclients 10$/,
     /^sv_licenseKey "secret-key"$/].each do |m|
      expect(subject).to render_file('/server/fivem/server.cfg').with_content(m)
    end
  end

  it 'creates file[/server/fivem/start-server.sh]' do
    expect(subject).to create_file('/server/fivem/start-server.sh')
      .with(owner: 'root',
            group: 'root',
            mode: '0755',
            content: 'base=$(pwd);pushd $base/server-data;bash $base/server/run.sh +exec $base/server.cfg;popd')
  end
end
