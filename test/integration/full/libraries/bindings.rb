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

  def initialize(bucket, project, owner_project, mode)
    @id = bucket
    @mode = mode
    @owner_project = owner_project
    @bindings = get_bindings(get_command(bucket, project))
  end

  def include?(entry)
    members = maybe_add_default_members_for_role(entry[:role], entry[:members])
    @bindings.include?(role: entry[:role], members: members)
  end

  private

  def get_command(bucket, project)
    "gsutil iam get gs://#{bucket} --project='#{project}' --format='json(bindings)'"
  end

  # Patch expected list of members of the bucket with the default users.
  # Example:
  #   role 'roles/storage.legacyBucketReader' is granted to all project viewers by default on bucket creation.
  def maybe_add_default_members_for_role(role, members)
    # `authoritative` mode must leave only the roles explicitely
    # specified in the terraform module.
    return members if @mode === 'authoritative'
    case role
    when 'roles/storage.legacyBucketReader'
      return ["projectViewer:#{@owner_project}"] + members # Order matters
    else
      return members
    end
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
