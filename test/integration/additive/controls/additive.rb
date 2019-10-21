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

# TODO: Get pure integer number from attributes (bug in InSpec).
# Roles amount are used to test how the module behaves on configuration updates.
roles = attribute('roles').to_i

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

  for folder in folders do
    describe folder_bindings(folder) do
      it { should include role: folder_roles[0], members: member_groups[0] } if roles >= 1
      it { should include role: folder_roles[1], members: member_groups[1] } if roles >= 2
    end
  end
end

# Subnets

control 'subnet-bindings' do
  title 'Test subnets bindings are correct'

  for subnet in subnets do
    describe subnet_bindings(subnet, project_id, region) do
      it { should include role: basic_roles[0], members: member_groups[0] } if roles >= 1
      it { should include role: basic_roles[1], members: member_groups[1] } if roles >= 2
    end
  end
end

# Buckets

control 'bucket-bindings' do
  title 'Test bucket bindings are correct'

  for bucket in buckets do
    describe bucket_bindings(bucket, projects[0]) do
      it { should include role: bucket_roles[0], members: member_groups[0] } if roles >= 1
      # in additive mode role 'roles/storage.legacyBucketReader' (which is being tested here)
      # has a `projectViewer:#{seed_project_id}` member assigned to it by default
      it { should include role: bucket_roles[1], members: ["projectViewer:#{project_id}"] + member_groups[1] }  if roles >= 2
    end
  end
end

# Projects

control 'project-bindings' do
  title 'Test projects bindings are correct'

  for project in projects do
    describe project_bindings(project) do
      it { should include role: project_roles[0], members: member_groups[0] } if roles >= 1
      it { should include role: project_roles[1], members: member_groups[1] } if roles >= 2
    end
  end
end

# Service Accounts

control 'service-account-bindings' do
  title 'Test service accounts bindings are correct'

  for service_account in service_accounts do
    describe service_account_bindings(service_account) do
      it { should include role: basic_roles[0], members: member_groups[0] } if roles >= 1
      it { should include role: basic_roles[1], members: member_groups[1] } if roles >= 2
    end
  end
end

# KMS Key Rings

control 'key-ring-bindings' do
  title 'Test key rings bindings are correct'

  for key_ring in key_rings do
    describe key_ring_bindings(key_ring) do
      it { should include role: basic_roles[0], members: member_groups[0] } if roles >= 1
      it { should include role: basic_roles[1], members: member_groups[1] } if roles >= 2
    end
  end
end

# KMS Crypto Keys

control 'key-bindings' do
  title 'Test keys bindings are correct'

  for key in keys do
    describe key_bindings(key) do
      it { should include role: basic_roles[0], members: member_groups[0] } if roles >= 1
      it { should include role: basic_roles[1], members: member_groups[1] } if roles >= 2
    end
  end
end

# Pubsub Topics

control 'topic-bindings' do
  title 'Test pubsub topics bindings are correct'

  for topic in topics do
    describe topic_bindings(topic, project_id) do
      it { should include role: basic_roles[0], members: member_groups[0] } if roles >= 1
      it { should include role: basic_roles[1], members: member_groups[1] } if roles >= 2
    end
  end
end

# Pubsub Subscriptions

control 'subscription-bindings' do
  title 'Test pubsub subscriptions bindings are correct'

  for subscription in subscriptions do
    describe subscription_bindings(subscription, project_id) do
      it { should include role: basic_roles[0], members: member_groups[0] } if roles >= 1
      it { should include role: basic_roles[1], members: member_groups[1] } if roles >= 2
    end
  end
end
