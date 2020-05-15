require_relative 'spec_helper'

describe 'fivem::es' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.override['fivem']['prefix'] = '/server'
    end.converge(described_recipe)
  end

  before do
    stub_command('test -f /server/fivem/essentialmode/fivem-es.zip').and_return(false)
  end

  it 'installs package[unzip]' do
    expect(subject).to install_package('unzip')
  end

  it 'creates directory[/server/fivem/essentialmode' do
    expect(subject).to create_directory('/server/fivem/essentialmode')
      .with(recursive: true)
  end

  it 'creates remote_file[/server/fivem/essentialmode/fivem-es.zip]' do
    zip = '/server/fivem/essentialmode/fivem-es.zip'
    expect(subject).to create_remote_file(zip)
      .with(source: 'https://kanersps.pw/files/essential5.zip',
            owner: 'root',
            group: 'root',
            mode: '0644')
    expect(subject.remote_file(zip)).to notify('execute[unzip]').to(:run)
    expect(subject.remote_file(zip)).to notify('link[essentialmode]').to(:create)
    expect(subject.remote_file(zip)).to notify('link[es_admin]').to(:create)
  end
end
