# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ENV['CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE'] = attribute('credentials_file_path')

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

# Role pairs (arrays of length = 2)
basic_roles   = attribute('basic_roles')
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

assert_bindings(
  'folder-0',
  "gcloud beta resource-manager folders get-iam-policy #{folders[0]} --format='json(bindings)'",
  basic_roles[0],
  member_groups[0],
)

assert_bindings(
  'folder-1',
  "gcloud beta resource-manager folders get-iam-policy #{folders[1]} --format='json(bindings)'",
  basic_roles[1],
  member_groups[1],
)

# Subnets

# Split a subnet name into its resources ids.
# Expected format: "projects/<project>/regions/<region>/subnetworks/<name>"
def split_subnet(sn)
  split = sn.split('/')
  return split[1], split[3], split[5]
end

subnet_0_project, subnet_0_region, subnet_0_name = split_subnet(subnets[0])

assert_bindings(
  'subnet-0',
  "gcloud beta compute networks subnets get-iam-policy #{subnet_0_name} --project='#{subnet_0_project}' --region='#{subnet_0_region}' --format='json(bindings)'",
  basic_roles[0],
  member_groups[0],
)

subnet_1_project, subnet_1_region, subnet_1_name = split_subnet(subnets[1])

assert_bindings(
  'subnet-1',
  "gcloud beta compute networks subnets get-iam-policy #{subnet_1_name} --project='#{subnet_1_project}' --region='#{subnet_1_region}' --format='json(bindings)'",
  basic_roles[1],
  member_groups[1],
)

# Projects

assert_bindings(
  'project-0',
  "gcloud projects get-iam-policy #{projects[0]} --format='json(bindings)'",
  project_roles[0],
  member_groups[0],
)

assert_bindings(
  'project-1',
  "gcloud projects get-iam-policy #{projects[1]} --format='json(bindings)'",
  project_roles[1],
  member_groups[1],
)

# Service Accounts

assert_bindings(
  'service-account-0',
  "gcloud iam service-accounts get-iam-policy #{service_accounts[0]} --format='json(bindings)'",
  basic_roles[0],
  member_groups[0],
)

assert_bindings(
  'service-account-1',
  "gcloud iam service-accounts get-iam-policy #{service_accounts[1]} --format='json(bindings)'",
  basic_roles[1],
  member_groups[1],
)

# KMS Key Rings

# Split a keyring name into its resources ids.
# Expected format: "projects/<project>/locations/<location>/keyRings/<name>"
def split_key_ring(kr)
  split = kr.split('/')
  return split[1], split[3], split[5]
end

keyring_0_project, keyring_0_location, keyring_0_name = split_key_ring(key_rings[0])

assert_bindings(
  'keyring-0',
  "gcloud kms keyrings get-iam-policy #{keyring_0_name} --project='#{keyring_0_project}' --location='#{keyring_0_location}' --format='json(bindings)'",
  basic_roles[0],
  member_groups[0],
)

keyring_1_project, keyring_1_location, keyring_1_name = split_key_ring(key_rings[1])

assert_bindings(
  'keyring-1',
  "gcloud kms keyrings get-iam-policy #{keyring_1_name} --project='#{keyring_1_project}' --location='#{keyring_1_location}' --format='json(bindings)'",
  basic_roles[1],
  member_groups[1],
)

# KMS Crypto Keys

# Split a key name into its resources ids.
# Expected format: "projects/<project>/locations/<location>/keyRings/<ring-name>/cryptoKeys/<key-name>"
def split_key(k)
  split = k.split('/')
  return split[1], split[3], split[5], split[7]
end

key_0_project, key_0_location, key_0_ring_name, key_0_name = split_key(keys[0])

assert_bindings(
  'key-0',
  "gcloud kms keys get-iam-policy #{key_0_name} --project='#{key_0_project}' --location='#{key_0_location}' --keyring='#{key_0_ring_name}' --format='json(bindings)'",
  basic_roles[0],
  member_groups[0],
)

key_1_project, key_1_location, key_1_ring_name, key_1_name = split_key(keys[1])

assert_bindings(
  'key-1',
  "gcloud kms keys get-iam-policy #{key_1_name} --project='#{key_1_project}' --location='#{key_1_location}' --keyring='#{key_1_ring_name}' --format='json(bindings)'",
  basic_roles[1],
  member_groups[1],
)

# Pubsub Topics

assert_bindings(
  'topic-0',
  "gcloud beta pubsub topics get-iam-policy #{topics[0]} --project='#{projects[0]}' --format='json(bindings)'",
  basic_roles[0],
  member_groups[0],
)

assert_bindings(
  'topic-1',
  "gcloud beta pubsub topics get-iam-policy #{topics[1]} --project='#{projects[0]}' --format='json(bindings)'",
  basic_roles[1],
  member_groups[1],
)

# Pubsub Subscriptions

assert_bindings(
  'subscription-0',
  "gcloud beta pubsub subscriptions get-iam-policy #{subscriptions[0]} --project='#{projects[0]}' --format='json(bindings)'",
  basic_roles[0],
  member_groups[0],
)

assert_bindings(
  'subscription-1',
  "gcloud beta pubsub subscriptions get-iam-policy #{subscriptions[1]} --project='#{projects[0]}' --format='json(bindings)'",
  basic_roles[1],
  member_groups[1],
)
