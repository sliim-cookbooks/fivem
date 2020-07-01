# Cookbook:: fivem
# Attributes:: mariadb_server
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

package 'gnupg'

mariadb_server_install 'FiveM MariaDB Server' do
  action [:install, :create]
  setup_repo true
  version node['fivem']['mariadb']['version']
  password node['fivem']['mariadb']['server']['password']
end

mariadb_server_configuration 'FiveM MariaDB Server Configuration' do
  version node['fivem']['mariadb']['version']
  mysqld_bind_address node['fivem']['mariadb']['server']['host']
  mysqld_port node['fivem']['mariadb']['server']['port']
end
