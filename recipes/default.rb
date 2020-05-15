# Cookbook:: fivem
# Recipe:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package 'xz-utils'

directory "#{node['fivem']['prefix']}/fivem/server" do
  recursive true
end

remote_file "#{node['fivem']['prefix']}/fivem/server/#{node['fivem']['version']}-fx.tar.xz" do
  source "https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/#{node['fivem']['version']}/fx.tar.xz"
  owner 'root'
  group 'root'
  mode '0644'
  not_if "test -f #{node['fivem']['version']}-fx.tar.xz"
  notifies :run, 'execute[untar-fx]', :immediately
end

execute 'untar-fx' do
  action :nothing
  command "tar xf #{node['fivem']['version']}-fx.tar.xz"
  cwd "#{node['fivem']['prefix']}/fivem/server"
end

git "#{node['fivem']['prefix']}/fivem/server-data" do
  repository node['fivem']['server_data']['repository']
  reference node['fivem']['server_data']['reference']
end

template "#{node['fivem']['prefix']}/fivem/server.cfg" do
  owner 'root'
  group 'root'
  mode '0644'
  source 'server.cfg.erb'
  variables endpoints: node['fivem']['endpoints'],
            resources: node['fivem']['resources'],
            config: node['fivem']['config']
end

file "#{node['fivem']['prefix']}/fivem/start-server.sh" do
  owner 'root'
  group 'root'
  mode '0755'
  content 'base=$(pwd);pushd $base/server-data;bash $base/server/run.sh +exec $base/server.cfg;popd'
end
