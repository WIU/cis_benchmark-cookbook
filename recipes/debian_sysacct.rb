#
# Cookbook Name:: cis-benchmark
# Recipe:: debian_sysacct
#
# Copyright 2011, Joshua Timberman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package 'sysstat' do
  action :upgrade
end

service 'sysstat' do
  supports restart: true, reload: true, status: true
  action [:enable, :start]
end

package 'auditd' do
  action :upgrade
end

template '/etc/audit/audit.rules' do
  source 'audit.rules.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, 'service[auditd]'
end

service 'auditd' do
  supports restart: true, reload: true, status: true
  action [:enable, :start]
end
