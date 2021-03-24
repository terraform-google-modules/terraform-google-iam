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

# Custom resource based on the InSpec resource DSL

# Base Class

class Bindings < Inspec.resource(1)
  name 'bindings'

  def initialize(*args)
    @id = args[0]
    @bindings = get_bindings(get_command(*args))
  end

  def to_s
    "<ID #{@id}>\n" + @bindings.join("\n")
  end

  def include?(*args)
    @bindings.include?(*args)
  end

  private

  def get_bindings(command)
    JSON.parse(inspec.command(command).stdout, symbolize_names: true)[:bindings]
  end
end

# Folders

class FolderBindings < Bindings
  name 'folder_bindings'
  private
  def get_command(folder)
    "gcloud beta resource-manager folders get-iam-policy #{folder} --format='json(bindings)'"
  end
end

# Subnets

class SubnetBindings < Bindings
  name 'subnet_bindings'
  private
  def get_command(subnet, project, region)
    "gcloud beta compute networks subnets get-iam-policy #{subnet} --project='#{project}' --region='#{region}' --format='json(bindings)'"
  end
end

# Buckets

class BucketBindings < Bindings
  name 'bucket_bindings'
  private
  def get_command(bucket, project)
    "gsutil iam get gs://#{bucket} --project='#{project}' --format='json(bindings)'"
  end
end

# Projects

class ProjectBindings < Bindings
  name 'project_bindings'
  private
  def get_command(project)
    "gcloud projects get-iam-policy #{project} --format='json(bindings)'"
  end
end

# Service Accounts

class ServiceAccountBindings < Bindings
  name 'service_account_bindings'
  private
  def get_command(service_account)
    "gcloud iam service-accounts get-iam-policy #{service_account} --format='json(bindings)'"
  end
end

# Key Rings

class KeyRingBindings < Bindings
  name 'key_ring_bindings'

  private

  def get_command(key_ring)
    key_ring_project, key_ring_location, key_ring_name = split_key_ring(key_ring)
    "gcloud kms keyrings get-iam-policy #{key_ring_name} --project='#{key_ring_project}' --location='#{key_ring_location}' --format='json(bindings)'"
  end

  # Split a keyring name into its resources ids.
  # Expected format: "projects/<project>/locations/<location>/keyRings/<name>"
  def split_key_ring(key_ring)
    split = key_ring.split('/')
    return split[1], split[3], split[5]
  end

end

# KMS Crypto Keys

class KeyBindings < Bindings
  name 'key_bindings'

  private

  def get_command(key)
    key_project, key_location, key_ring_name, key_name = split_key(key)
    "gcloud kms keys get-iam-policy #{key_name} --project='#{key_project}' --location='#{key_location}' --keyring='#{key_ring_name}' --format='json(bindings)'"
  end

  # Split a key name into its resources ids.
  # Expected format: "projects/<project>/locations/<location>/keyRings/<ring-name>/cryptoKeys/<key-name>"
  def split_key(k)
    split = k.split('/')
    return split[1], split[3], split[5], split[7]
  end

end

# Pubsub Topics

class TopicBindings < Bindings
  name 'topic_bindings'
  private
  def get_command(topic, project)
    "gcloud beta pubsub topics get-iam-policy #{topic} --project='#{project}' --format='json(bindings)'"
  end
end

# Pubsub Subscriptions

class SubscriptionBindings < Bindings
  name 'subscription_bindings'
  private
  def get_command(subscription, project)
    "gcloud beta pubsub subscriptions get-iam-policy #{subscription} --project='#{project}' --format='json(bindings)'"
  end
end

# Secret Manager

class SecretManager < Bindings
  name 'secret_bindings'
  private
  def get_command(secret, project)
    "gcloud beta secrets get-iam-policy #{secret} --project='#{project}' --format='json(bindings)'"
  end
end
