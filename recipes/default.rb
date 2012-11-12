#
# Cookbook Name:: metarepo
# Recipe:: default
#
# Copyright 2012, Heavy Water Operations, LLC
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

node.default['ruby_installer']['package_name'] = "ruby1.9.3"

include_recipe "git"
include_recipe "ubuntu"
include_recipe "ruby_installer"
include_recipe "postgresql::server"
include_recipe "postgresql::client"
include_recipe "redis::server"

directory node['metarepo']['directory'] do
  owner node['metarepo']['user']
  group node['metarepo']['group']
end

git node['metarepo']['directory'] do
  repository node['metarepo']['git_url']
  revision node['metarepo']['git_branch']
  action node['metarepo']['git_action']
  user node['metarepo']['user']
  group node['metarepo']['group']
end

gem_package "bundler"

execute "metarepo: bundle" do
  command "bundle install --deployment"
  subscribes :run, resources(:git => node['metarepo']['directory']), :immediately
  cwd node['metarepo']['directory']
  user node['metarepo']['user']
  group node['metarepo']['group']
  creates File.join(node['metarepo']['directory'], ".bundle")
end

# runit_service "resque"
runit_service "metarepo"
