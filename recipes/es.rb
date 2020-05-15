# Cookbook:: fivem
# Attributes:: es
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

package 'unzip'

directory "#{node['fivem']['prefix']}/fivem/essentialmode" do
  recursive true
end

remote_file "#{node['fivem']['prefix']}/fivem/essentialmode/fivem-es.zip" do
  source 'https://kanersps.pw/files/essential5.zip'
  owner 'root'
  group 'root'
  mode '0644'
  not_if "test -f #{node['fivem']['prefix']}/fivem/essentialmode/fivem-es.zip"
  notifies :run, 'execute[unzip]', :immediately
  notifies :create, 'link[essentialmode]', :immediately
  notifies :create, 'link[es_admin]', :immediately
end

execute 'unzip' do
  action :nothing
  command 'unzip fivem-es.zip'
  cwd "#{node['fivem']['prefix']}/fivem/essentialmode"
end

link 'essentialmode' do
  action :nothing
  target_file "#{node['fivem']['prefix']}/fivem/server-data/resources/essentialmode"
  to "#{node['fivem']['prefix']}/fivem/essentialmode/essentialmode-master"
end

link 'es_admin' do
  action :nothing
  target_file "#{node['fivem']['prefix']}/fivem/server-data/resources/es_admin"
  to "#{node['fivem']['prefix']}/fivem/essentialmode/es_admin-master"
end

# TODO: https://github.com/ESX-Org/es_extended
