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

# Roles amount are used to test how the module behaves on configuration updates.
# Workaround InSpec lack of support for integer by parsing it from string.
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
audit_config     = attribute('audit_config')
secrets          = attribute('secrets')

# Role pairs (arrays of length = 2)
basic_roles               = attribute('basic_roles')
folder_roles              = attribute('folder_roles')
org_roles                 = attribute('org_roles')
project_roles             = attribute('project_roles')
project_conditional_roles = attribute('project_conditional_roles')
bucket_roles              = attribute('bucket_roles')

# Pair of member groupings
member_groups = [
  attribute('member_group_0'),
  attribute('member_group_1')
]

# Condition for conditional bindings
bindings_condition = attribute('bindings_condition').transform_keys!(&:to_sym)

# Folders

control 'folder-bindings' do
  title 'Test folder bindings are correct'

  describe folders.map { |folder| folder_bindings(folder) } do
    it 'include the 1st binding' do
      if roles < 1
        skip 'less than 1 roles specified'
      else
        should all include role: folder_roles[0], members: member_groups[0]
      end
    end

    it 'include the 2st binding' do
      if roles < 2
        skip 'less than 2 roles specified'
      else
        should all include role: folder_roles[1], members: member_groups[1]
      end
    end
  end
end

# Subnets

control 'subnet-bindings' do
  title 'Test subnets bindings are correct'

  describe subnets.map { |subnet| subnet_bindings(subnet, project_id, region) } do
    it 'include the 1st binding' do
      if roles < 1
        skip 'less than 1 roles specified'
      else
        should all include role: basic_roles[0], members: member_groups[0]
      end
    end

    it 'include the 2st binding' do
      if roles < 2
        skip 'less than 2 roles specified'
      else
        should all include role: basic_roles[1], members: member_groups[1]
      end
    end
  end
end

# Buckets

control 'bucket-bindings' do
  title 'Test bucket bindings are correct'

  describe buckets.map { |bucket| bucket_bindings(bucket, projects[0]) } do
    it 'include the 1st binding' do
      if roles < 1
        skip 'less than 1 roles specified'
      else
        should all include role: bucket_roles[0], members: member_groups[0]
      end
    end

    it 'include the 2st binding' do
      if roles < 2
        skip 'less than 2 roles specified'
      else
        should all include role: bucket_roles[1], members: member_groups[1]
      end
    end
  end
end

# Projects

control 'project-bindings' do
  title 'Test projects bindings are correct'

  describe projects.map { |project| project_bindings(project) } do
    it 'include the 1st binding' do
      if roles < 1
        skip 'less than 1 roles specified'
      else
        should all include role: project_roles[0], members: member_groups[0]
      end
    end

    it 'include the 2st binding' do
      if roles < 2
        skip 'less than 2 roles specified'
      else
        should all include role: project_roles[1], members: member_groups[1]
      end
    end
  end
end

# Projects conditional bindings

control 'project-conditional-bindings' do
  title 'Test projects conditional bindings are correct'

  describe projects.map { |project| project_bindings(project) } do
    it 'include the 1st binding' do
      if roles < 1
        skip 'less than 1 roles specified'
      else
        should all include role: project_conditional_roles[0], members: member_groups[0], condition: bindings_condition
      end
    end

    it 'include the 2st binding' do
      if roles < 2
        skip 'less than 2 roles specified'
      else
        should all include role: project_conditional_roles[1], members: member_groups[1], condition: bindings_condition
      end
    end
  end
end

# Service Accounts

control 'service-account-bindings' do
  title 'Test service accounts bindings are correct'

  describe service_accounts.map { |service_account| service_account_bindings(service_account) } do
    it 'include the 1st binding' do
      if roles < 1
        skip 'less than 1 roles specified'
      else
        should all include role: basic_roles[0], members: member_groups[0]
      end
    end

    it 'include the 2st binding' do
      if roles < 2
        skip 'less than 2 roles specified'
      else
        should all include role: basic_roles[1], members: member_groups[1]
      end
    end
  end
end

# KMS Key Rings

control 'key-ring-bindings' do
  title 'Test key rings bindings are correct'

  describe key_rings.map { |key_ring| key_ring_bindings(key_ring) } do
    it 'include the 1st binding' do
      if roles < 1
        skip 'less than 1 roles specified'
      else
        should all include role: basic_roles[0], members: member_groups[0]
      end
    end

    it 'include the 2st binding' do
      if roles < 2
        skip 'less than 2 roles specified'
      else
        should all include role: basic_roles[1], members: member_groups[1]
      end
    end
  end
end

# KMS Crypto Keys

control 'key-bindings' do
  title 'Test keys bindings are correct'

  describe keys.map { |key| key_bindings(key) } do
    it 'include the 1st binding' do
      if roles < 1
        skip 'less than 1 roles specified'
      else
        should all include role: basic_roles[0], members: member_groups[0]
      end
    end

    it 'include the 2st binding' do
      if roles < 2
        skip 'less than 2 roles specified'
      else
        should all include role: basic_roles[1], members: member_groups[1]
      end
    end
  end
end

# Pubsub Topics

control 'topic-bindings' do
  title 'Test pubsub topics bindings are correct'

  describe topics.map { |topic| topic_bindings(topic, project_id) } do
    it 'include the 1st binding' do
      if roles < 1
        skip 'less than 1 roles specified'
      else
        should all include role: basic_roles[0], members: member_groups[0]
      end
    end

    it 'include the 2st binding' do
      if roles < 2
        skip 'less than 2 roles specified'
      else
        should all include role: basic_roles[1], members: member_groups[1]
      end
    end
  end
end

# Pubsub Subscriptions

control 'subscription-bindings' do
  title 'Test pubsub subscriptions bindings are correct'

  describe subscriptions.map { |subscription| subscription_bindings(subscription, project_id) } do
    it 'include the 1st binding' do
      if roles < 1
        skip 'less than 1 roles specified'
      else
        should all include role: basic_roles[0], members: member_groups[0]
      end
    end

    it 'include the 2st binding' do
      if roles < 2
        skip 'less than 2 roles specified'
      else
        should all include role: basic_roles[1], members: member_groups[1]
      end
    end
  end
end

# Audit config

control 'audit-log-config' do
  title 'Test if audit log config is correct'

  describe command ("gcloud projects get-iam-policy #{project_id} --format='json(auditConfigs)'") do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should eq '' }
    let!(:data) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout)
      else
        {}
      end
    end
    describe "check auditConfigs count" do
      it "has two auditConfigs" do
        expect(data["auditConfigs"].length).to eq 2
      end
    end
    describe "check members email" do
      it "has correct exemptedMembers" do
        data["auditConfigs"].each do |config|
          expect([audit_config[0][:exempted_members][0], audit_config[1][:exempted_members][0]]).to include(
              config["auditLogConfigs"][0]["exemptedMembers"][0]
            )
          end
      end
    end
    describe "check log type " do
      it "has correct log type" do
        expect(data["auditConfigs"][0]["auditLogConfigs"][0]["logType"]).to eq audit_config[0][:log_type]
      end
    end
    describe "check services " do
      it "has correct Services" do
        data["auditConfigs"].each do |config|
          expect([audit_config[0][:service],audit_config[1][:service]]).to include (
            config["service"]
          )
        end
      end
    end
  end
end

# Secret Manager

control 'secret-bindings' do
  title 'Test secret manager bindings are correct'

  describe secrets.map { |secret| secret_bindings(secret, project_id) } do
    it 'include the 1st binding' do
      if roles < 1
        skip 'less than 1 roles specified'
      else
        should all include role: basic_roles[0], members: member_groups[0]
      end
    end

    it 'include the 2st binding' do
      if roles < 2
        skip 'less than 2 roles specified'
      else
        should all include role: basic_roles[1], members: member_groups[1]
      end
    end
  end
end
