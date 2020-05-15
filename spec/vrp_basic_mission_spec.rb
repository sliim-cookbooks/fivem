require_relative 'spec_helper'

describe 'fivem::vrp_basic_mission' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.override['fivem']['prefix'] = '/server'
      node.override['fivem']['vrp_bm']['repository'] = 'https://my/host/vrp-basic-mission.git'
      node.override['fivem']['vrp_bm']['reference'] = 'dev'
    end.converge(described_recipe)
  end

  it 'syncs git[/server/fivem/vrp-basic-mission]' do
    expect(subject).to sync_git('/server/fivem/vrp-basic-mission')
      .with(repository: 'https://my/host/vrp-basic-mission.git',
            reference: 'dev')
  end

  it 'creates link[/server/fivem/server-data/resources/vrp_basic_mission]' do
    expect(subject).to create_link('/server/fivem/server-data/resources/vrp_basic_mission')
      .with(to: '/server/fivem/vrp-basic-mission/vrp_basic_mission')
  end
end
