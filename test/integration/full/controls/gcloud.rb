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

# Mode of IAM management ('authoritative' OR 'additive')
mode = attribute('mode')

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

# Asserts that the resource has the correct role-member bindings.
def assert_bindings(name, cmd, expected_role, expected_members)
  control "#{name}-bindings" do
    describe command(cmd) do
      its('exit_status') { should eq 0 }
      its('stderr') { should eq '' }

      let(:output) do
        if subject.exit_status == 0
          JSON.parse(subject.stdout, symbolize_names: true)
        else
          {}
        end
      end

      it { expect(output).to include bindings: including(role: expected_role, members: expected_members) }
    end
  end
end

# Folders

def assert_folder_bindings(name, folder, expected_role, expected_members)
  assert_bindings(
    name,
    "gcloud beta resource-manager folders get-iam-policy #{folder} --format='json(bindings)'",
    expected_role,
    expected_members,
  )
end

assert_folder_bindings('folder-0-role-0', folders[0], folder_roles[0], member_groups[0])
assert_folder_bindings('folder-0-role-1', folders[0], folder_roles[1], member_groups[1])
assert_folder_bindings('folder-1-role-0', folders[1], folder_roles[0], member_groups[0])
assert_folder_bindings('folder-1-role-1', folders[1], folder_roles[1], member_groups[1])

# Subnets

def assert_subnet_bindings(name, project, subnet, region, expected_role, expected_members)
  assert_bindings(
    name,
    "gcloud beta compute networks subnets get-iam-policy #{subnet} --project='#{project}' --region='#{region}' --format='json(bindings)'",
    expected_role,
    expected_members,
  )
end

assert_subnet_bindings('subnet-0-role-0', project_id, subnets[0], region, basic_roles[0], member_groups[0])
assert_subnet_bindings('subnet-0-role-1', project_id, subnets[0], region, basic_roles[1], member_groups[1])
assert_subnet_bindings('subnet-1-role-0', project_id, subnets[1], region, basic_roles[0], member_groups[0])
assert_subnet_bindings('subnet-1-role-1', project_id, subnets[1], region, basic_roles[1], member_groups[1])

# Buckets

def assert_bucket_bindings(name, project, owner_project, bucket, expected_role, expected_members, mode)
  assert_bindings(
    name,
    # TODO: Remove explicit `--format='json(bindings)'` since it doesn't seem to be needed in gsutil,
    #       and I haven't even found any support for it at all.
    #       Gsutil already returns JSON for iam bindings by default.
    #       We might leave it for the case of future gsutil api changes which might bring in the gcloud apis.
    "gsutil iam get gs://#{bucket} --project='#{project}' --format='json(bindings)'",
    expected_role,
    maybe_add_default_members_for_role(expected_role, expected_members, owner_project, mode)
  )
end

# Patch expected list of members of the bucket with the default users.
# Example:
#   role 'roles/storage.legacyBucketReader' is granted to all project viewers by default on bucket creation.
def maybe_add_default_members_for_role(role, members, owner_project, mode)
  # `authoritative` mode must leave only the roles explicitely
  # specified in the terraform module.
  return members if mode === 'authoritative'
  case role
  when 'roles/storage.legacyBucketReader'
    return ["projectViewer:#{owner_project}"] + members # Order matters
  else
    return members
  end
end

assert_bucket_bindings('bucket-0-role-0', projects[0], project_id, buckets[0], bucket_roles[0], member_groups[0], mode)
assert_bucket_bindings('bucket-0-role-1', projects[0], project_id, buckets[0], bucket_roles[1], member_groups[1], mode)
assert_bucket_bindings('bucket-1-role-0', projects[0], project_id, buckets[1], bucket_roles[0], member_groups[0], mode)
assert_bucket_bindings('bucket-1-role-1', projects[0], project_id, buckets[1], bucket_roles[1], member_groups[1], mode)

# Projects

def assert_project_bindings(name, project, expected_role, expected_members)
  assert_bindings(
    name,
    "gcloud projects get-iam-policy #{project} --format='json(bindings)'",
    expected_role,
    expected_members,
  )
end

assert_project_bindings('project-0-role-0', projects[0], project_roles[0], member_groups[0])
assert_project_bindings('project-0-role-1', projects[0], project_roles[1], member_groups[1])
assert_project_bindings('project-1-role-0', projects[1], project_roles[0], member_groups[0])
assert_project_bindings('project-1-role-1', projects[1], project_roles[1], member_groups[1])

# Service Accounts

def assert_service_account_bindings(name, service_account, expected_role, expected_members)
  assert_bindings(
    name,
    "gcloud iam service-accounts get-iam-policy #{service_account} --format='json(bindings)'",
    expected_role,
    expected_members,
  )
end

assert_service_account_bindings('service-account-0-role-0', service_accounts[0], basic_roles[0], member_groups[0])
assert_service_account_bindings('service-account-0-role-1', service_accounts[0], basic_roles[1], member_groups[1])
assert_service_account_bindings('service-account-1-role-0', service_accounts[1], basic_roles[0], member_groups[0])
assert_service_account_bindings('service-account-1-role-1', service_accounts[1], basic_roles[1], member_groups[1])

# KMS Key Rings

# Split a keyring name into its resources ids.
# Expected format: "projects/<project>/locations/<location>/keyRings/<name>"
def split_key_ring(kr)
  split = kr.split('/')
  return split[1], split[3], split[5]
end

def assert_key_ring_bindings(name, key_ring, expected_role, expected_members)
  key_ring_project, key_ring_location, key_ring_name = split_key_ring(key_ring)
  assert_bindings(
    name,
    "gcloud kms keyrings get-iam-policy #{key_ring_name} --project='#{key_ring_project}' --location='#{key_ring_location}' --format='json(bindings)'",
    expected_role,
    expected_members,
  )
end

assert_key_ring_bindings('keyring-0-role-0', key_rings[0], basic_roles[0], member_groups[0])
assert_key_ring_bindings('keyring-0-role-1', key_rings[0], basic_roles[1], member_groups[1])
assert_key_ring_bindings('keyring-1-role-0', key_rings[1], basic_roles[0], member_groups[0])
assert_key_ring_bindings('keyring-1-role-1', key_rings[1], basic_roles[1], member_groups[1])

# KMS Crypto Keys

# Split a key name into its resources ids.
# Expected format: "projects/<project>/locations/<location>/keyRings/<ring-name>/cryptoKeys/<key-name>"
def split_key(k)
  split = k.split('/')
  return split[1], split[3], split[5], split[7]
end

def assert_key_bindings(name, key, expected_role, expected_members)
  key_project, key_location, key_ring_name, key_name = split_key(key)
  assert_bindings(
    name,
    "gcloud kms keys get-iam-policy #{key_name} --project='#{key_project}' --location='#{key_location}' --keyring='#{key_ring_name}' --format='json(bindings)'",
    expected_role,
    expected_members,
  )
end

assert_key_bindings('key-0-role-0', keys[0], basic_roles[0], member_groups[0])
assert_key_bindings('key-0-role-1', keys[0], basic_roles[1], member_groups[1])
assert_key_bindings('key-1-role-0', keys[1], basic_roles[0], member_groups[0])
assert_key_bindings('key-1-role-1', keys[1], basic_roles[1], member_groups[1])

# Pubsub Topics

def assert_topic_bindings(name, topic, project, expected_role, expected_members)
  assert_bindings(
    name,
    "gcloud beta pubsub topics get-iam-policy #{topic} --project='#{project}' --format='json(bindings)'",
    expected_role,
    expected_members,
  )
end

assert_topic_bindings('topic-0-role-0', topics[0], project_id, basic_roles[0], member_groups[0])
assert_topic_bindings('topic-0-role-1', topics[0], project_id, basic_roles[1], member_groups[1])
assert_topic_bindings('topic-1-role-0', topics[1], project_id, basic_roles[0], member_groups[0])
assert_topic_bindings('topic-1-role-1', topics[1], project_id, basic_roles[1], member_groups[1])

# Pubsub Subscriptions

def assert_subscription_bindings(name, subscription, project, expected_role, expected_members)
  assert_bindings(
    name,
    "gcloud beta pubsub subscriptions get-iam-policy #{subscription} --project='#{project}' --format='json(bindings)'",
    expected_role,
    expected_members,
  )
end

assert_subscription_bindings('subscription-0-role-0', subscriptions[0], project_id, basic_roles[0], member_groups[0])
assert_subscription_bindings('subscription-0-role-1', subscriptions[0], project_id, basic_roles[1], member_groups[1])
assert_subscription_bindings('subscription-1-role-0', subscriptions[1], project_id, basic_roles[0], member_groups[0])
assert_subscription_bindings('subscription-1-role-1', subscriptions[1], project_id, basic_roles[1], member_groups[1])
