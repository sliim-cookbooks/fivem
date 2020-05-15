# Cookbook:: fivem
# Attributes:: default
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

default['fivem']['prefix'] = '/opt'
default['fivem']['version'] = '2431-350dd7bd5c0176216c38625ad5b1108ead44674d'

default['fivem']['server_data']['repository'] = 'https://github.com/citizenfx/cfx-server-data'
default['fivem']['server_data']['reference'] = 'master'

default['fivem']['endpoints'] = {
  'tcp' => '0.0.0.0:30120',
  'udp' => '0.0.0.0:30120',
}

default['fivem']['resources'] = %w(
  mapmanager
  chat
  spawnmanager
  sessionmanager
  fivem
  hardcap
  rconlog
  scoreboard
  playernames
)

default['fivem']['config'] = {
  'sets tags' => 'default',
  # 'sets banner_detail' => '',
  # 'sets banner_connecting' => '',
  'sv_hostname' => 'My FXServer configured with Chef!',
  # 'load_server_icon' => 'myLogo.png',
  'set temp_convar' => 'hey world!',
  'sv_master1' => '',
  # 'sv_authMaxVariance' => 1,
  # 'sv_authMinTrust' => 5,
  'add_ace group.admin command' => 'allow',
  'add_ace group.admin command.quit' => 'deny',
  'add_principal identifier.steam:01234567890123456' => 'group.admin',
  'sv_endpointprivacy' => true,
  'sv_maxclients' => 30,
  'sv_licenseKey' => 'db332950d108e8340f04a7685df9a280',
}
