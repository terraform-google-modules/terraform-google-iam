# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Fixture project as managed in cloud-foundation-toolkit/infra
project_id = attribute('project_id')

# Resource pairs (arrays of length = 2)
folders          = attribute('folders')
subnets          = attribute('subnets')
projects         = attribute('projects')
service_accounts = attribute('service_accounts')
buckets          = attribute('buckets')
key_rings        = attribute('key_rings')
keys             = attribute('keys')
topics           = attribute('topics')
subscriptions    = attribute('subscriptions')
region           = attribute('region')

# Role pairs (arrays of length = 2)
basic_roles   = attribute('basic_roles')
folder_roles  = attribute('folder_roles')
org_roles     = attribute('org_roles')
project_roles = attribute('project_roles')
bucket_roles  = attribute('bucket_roles')

# Pair of member groupings
member_groups = [
  attribute('member_group_0'),
  attribute('member_group_1')
]

# Folders

control 'folder-bindings' do
  title 'Test folder bindings are correct'

  describe folder_bindings(folders[0]) do
    it { should include role: folder_roles[0], members: member_groups[0] }
    it { should include role: folder_roles[1], members: member_groups[1] }
  end

  describe folder_bindings(folders[1]) do
    it { should include role: folder_roles[0], members: member_groups[0] }
    it { should include role: folder_roles[1], members: member_groups[1] }
  end
end

# Subnets

control 'subnet-bindings' do
  title 'Test subnets bindings are correct'

  describe subnet_bindings(subnets[0], project_id, region) do
    it { should include role: basic_roles[0], members: member_groups[0] }
    it { should include role: basic_roles[1], members: member_groups[1] }
  end

  describe subnet_bindings(subnets[1], project_id, region) do
    it { should include role: basic_roles[0], members: member_groups[0] }
    it { should include role: basic_roles[1], members: member_groups[1] }
  end
end

# Buckets

control 'bucket-bindings' do
  title 'Test bucket bindings are correct'

  describe bucket_bindings(buckets[0], projects[0]) do
    it { should include role: bucket_roles[0], members: member_groups[0] }
    it { should include role: bucket_roles[1], members: member_groups[1] }
  end

  describe bucket_bindings(buckets[1], projects[0]) do
    it { should include role: bucket_roles[0], members: member_groups[0] }
    it { should include role: bucket_roles[1], members: member_groups[1] }
  end
end

# Projects

control 'project-bindings' do
  title 'Test projects bindings are correct'

  describe project_bindings(projects[0]) do
    it { should include role: project_roles[0], members: member_groups[0] }
    it { should include role: project_roles[1], members: member_groups[1] }
  end

  describe project_bindings(projects[1]) do
    it { should include role: project_roles[0], members: member_groups[0] }
    it { should include role: project_roles[1], members: member_groups[1] }
  end
end

# Service Accounts

control 'service-account-bindings' do
  title 'Test service accounts bindings are correct'

  describe service_account_bindings(service_accounts[0]) do
    it { should include role: basic_roles[0], members: member_groups[0] }
    it { should include role: basic_roles[1], members: member_groups[1] }
  end

  describe service_account_bindings(service_accounts[1]) do
    it { should include role: basic_roles[0], members: member_groups[0] }
    it { should include role: basic_roles[1], members: member_groups[1] }
  end
end

# KMS Key Rings

control 'key-ring-bindings' do
  title 'Test key rings bindings are correct'

  describe key_ring_bindings(key_rings[0]) do
    it { should include role: basic_roles[0], members: member_groups[0] }
    it { should include role: basic_roles[1], members: member_groups[1] }
  end

  describe key_ring_bindings(key_rings[1]) do
    it { should include role: basic_roles[0], members: member_groups[0] }
    it { should include role: basic_roles[1], members: member_groups[1] }
  end
end

# KMS Crypto Keys

control 'key-bindings' do
  title 'Test keys bindings are correct'

  describe key_bindings(keys[0]) do
    it { should include role: basic_roles[0], members: member_groups[0] }
    it { should include role: basic_roles[1], members: member_groups[1] }
  end

  describe key_bindings(keys[1]) do
    it { should include role: basic_roles[0], members: member_groups[0] }
    it { should include role: basic_roles[1], members: member_groups[1] }
  end
end

# Pubsub Topics

control 'topic-bindings' do
  title 'Test pubsub topics bindings are correct'

  describe topic_bindings(topics[0], project_id) do
    it { should include role: basic_roles[0], members: member_groups[0] }
    it { should include role: basic_roles[1], members: member_groups[1] }
  end

  describe topic_bindings(topics[1], project_id) do
    it { should include role: basic_roles[0], members: member_groups[0] }
    it { should include role: basic_roles[1], members: member_groups[1] }
  end
end

# Pubsub Subscriptions

control 'subscription-bindings' do
  title 'Test pubsub subscriptions bindings are correct'

  describe subscription_bindings(subscriptions[0], project_id) do
    it { should include role: basic_roles[0], members: member_groups[0] }
    it { should include role: basic_roles[1], members: member_groups[1] }
  end

  describe subscription_bindings(subscriptions[1], project_id) do
    it { should include role: basic_roles[0], members: member_groups[0] }
    it { should include role: basic_roles[1], members: member_groups[1] }
  end
end
