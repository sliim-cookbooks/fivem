# Cookbook:: fivem
# Attributes:: mysql_async
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

git "#{node['fivem']['prefix']}/fivem/mysql-async" do
  repository node['fivem']['mysql_async']['repository']
  reference node['fivem']['mysql_async']['reference']
end

link "#{node['fivem']['prefix']}/fivem/server-data/resources/mysql-async" do
  to "#{node['fivem']['prefix']}/fivem/mysql-async"
end
