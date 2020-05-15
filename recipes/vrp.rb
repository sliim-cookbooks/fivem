# Cookbook:: fivem
# Attributes:: vrp
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

package 'libmariadbclient-dev-compat'
package 'gnupg'

mariadb_client_install 'FiveM MariaDB Client' do
  version node['fivem']['mariadb']['version']
  action :install
end

gem_package 'mysql2' do
  gem_binary RbConfig::CONFIG['bindir'] + '/gem'
  version '0.4.9'
  action :install
end

mariadb_database 'vrp' do
  action :create
  host '127.0.0.1'
  user 'root'
end

mariadb_user 'vrp' do
  action [:create, :grant]
  password 'vrp'
  database_name 'vrp'
  privileges [:all]
  host '%'
end

git "#{node['fivem']['prefix']}/fivem/vrp" do
  repository node['fivem']['vrp']['repository']
  reference node['fivem']['vrp']['reference']
end

%w(vrp vrp_mysql).each do |resource|
  link "#{node['fivem']['prefix']}/fivem/server-data/resources/#{resource}" do
    to "#{node['fivem']['prefix']}/fivem/vrp/#{resource}"
  end
end
