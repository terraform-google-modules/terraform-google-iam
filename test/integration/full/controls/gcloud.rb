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
folders         = attribute('folders')
subnets         = attribute('subnets')
projects        = attribute('projects')
serviceAccounts = attribute('service_accounts')
buckets         = attribute('buckets')
keyRings        = attribute('key_rings')
keys            = attribute('keys')
topics          = attribute('topics')
subscriptions   = attribute('subscriptions')

# Role pairs (arrays of length = 2)
basicRoles   = attribute('basic_roles')
orgRoles     = attribute('org_roles')
projectRoles = attribute('project_roles')
bucketRoles  = attribute('bucket_roles')

# Pair of member groupings
memberGroups = [
  attribute('member_group_0'),
  attribute('member_group_1')
]

# Asserts that the resource has the correct role-member bindings.
def assertBindings(name, cmd, expectedRole, expectedMembers)
  control "#{name}-bindings" do
    describe command(cmd) do
      its('exit_status') { should eq 0 }
      its('stderr') { should eq '' }

      let(:members) do
        if subject.exit_status == 0
          res = JSON.parse(subject.stdout, symbolize_names: true)
          # TODO: Assert before drilling into json.
          bindings = res[:bindings]
          bindings.find { |b| b[:'role'] == expectedRole }[:members]
        else
          {}
        end
      end
  
      it { expect(members).to include(*expectedMembers) }

    end
  end
end

# Folders

assertBindings(
  'folder-0',
  "gcloud beta resource-manager folders get-iam-policy #{folders[0]} --format='json(bindings)'",
  basicRoles[0],
  memberGroups[0],
)

assertBindings(
  'folder-1',
  "gcloud beta resource-manager folders get-iam-policy #{folders[1]} --format='json(bindings)'",
  basicRoles[1],
  memberGroups[1],
)

# Subnets

# Split a subnet name into its resources ids.
# Expected format: "projects/<project>/regions/<region>/subnetworks/<name>"
def splitSubnet(sn)
  split = sn.split('/')
  return split[1], split[3], split[5]
end

subnet0Project, subnet0Region, subnet0Name = splitSubnet(subnets[0])
assertBindings(
  'subnet-0',
  "gcloud beta compute networks subnets get-iam-policy #{subnet0Name} --project='#{subnet0Project}' --region='#{subnet0Region}' --format='json(bindings)'",
  basicRoles[0],
  memberGroups[0],
)

subnet1Project, subnet1Region, subnet1Name = splitSubnet(subnets[1])
assertBindings(
  'subnet-1',
  "gcloud beta compute networks subnets get-iam-policy #{subnet1Name} --project='#{subnet1Project}' --region='#{subnet1Region}' --format='json(bindings)'",
  basicRoles[1],
  memberGroups[1],
)

# Projects

assertBindings(
  'project-0',
  "gcloud projects get-iam-policy #{projects[0]} --format='json(bindings)'",
  projectRoles[0],
  memberGroups[0],
)

assertBindings(
  'project-1',
  "gcloud projects get-iam-policy #{projects[1]} --format='json(bindings)'",
  projectRoles[1],
  memberGroups[1],
)

# Service Accounts

assertBindings(
  'service-account-0',
  "gcloud iam service-accounts get-iam-policy #{serviceAccounts[0]} --format='json(bindings)'",
  basicRoles[0],
  memberGroups[0],
)

assertBindings(
  'service-account-1',
  "gcloud iam service-accounts get-iam-policy #{serviceAccounts[1]} --format='json(bindings)'",
  basicRoles[1],
  memberGroups[1],
)

# KMS Keyrings

# Split a keyring name into its resources ids.
# Expected format: "projects/<project>/locations/<location>/keyRings/<name>"
def splitKeyRing(kr)
  split = kr.split('/')
  return split[1], split[3], split[5]
end

keyRing0Project, keyRing0Location, keyRing0Name = splitKeyRing(keyRings[0])
assertBindings(
  'keyring-0',
  "gcloud kms keyrings get-iam-policy #{keyRing0Name} --project='#{keyRing0Project}' --location='#{keyRing0Location}' --format='json(bindings)'",
  basicRoles[0],
  memberGroups[0],
)

keyRing1Project, keyRing1Location, keyRing1Name = splitKeyRing(keyRings[1])
assertBindings(
  'keyring-1',
  "gcloud kms keyrings get-iam-policy #{keyRing1Name} --project='#{keyRing1Project}' --location='#{keyRing1Location}' --format='json(bindings)'",
  basicRoles[1],
  memberGroups[1],
)

# KMS Crypto Keys

# Split a key name into its resources ids.
# Expected format: "projects/<project>/locations/<location>/keyRings/<ring-name>/cryptoKeys/<key-name>"
def splitKey(k)
  split = k.split('/')
  return split[1], split[3], split[5], split[7]
end

key0Project, key0Location, key0RingName, key0Name = splitKey(keys[0])
assertBindings(
  'key-0',
  "gcloud kms keys get-iam-policy #{key0Name} --project='#{key0Project}' --location='#{key0Location}' --keyring='#{key0RingName}' --format='json(bindings)'",
  basicRoles[0],
  memberGroups[0],
)

key1Project, key1Location, key1RingName, key1Name = splitKey(keys[1])
assertBindings(
  'key-1',
  "gcloud kms keys get-iam-policy #{key1Name} --project='#{key1Project}' --location='#{key1Location}' --keyring='#{key1RingName}' --format='json(bindings)'",
  basicRoles[1],
  memberGroups[1],
)

# Pubsub Topics

assertBindings(
  'topic-0',
  "gcloud beta pubsub topics get-iam-policy #{topics[0]} --project='#{projects[0]}' --format='json(bindings)'",
  basicRoles[0],
  memberGroups[0],
)

assertBindings(
  'topic-1',
  "gcloud beta pubsub topics get-iam-policy #{topics[1]} --project='#{projects[0]}' --format='json(bindings)'",
  basicRoles[1],
  memberGroups[1],
)

# Pubsub Subscriptions

assertBindings(
  'subscription-0',
  "gcloud beta pubsub subscriptions get-iam-policy #{subscriptions[0]} --project='#{projects[0]}' --format='json(bindings)'",
  basicRoles[0],
  memberGroups[0],
)

assertBindings(
  'subscription-1',
  "gcloud beta pubsub subscriptions get-iam-policy #{subscriptions[1]} --project='#{projects[0]}' --format='json(bindings)'",
  basicRoles[1],
  memberGroups[1],
)

# TODO: Bucket binding assertions.
