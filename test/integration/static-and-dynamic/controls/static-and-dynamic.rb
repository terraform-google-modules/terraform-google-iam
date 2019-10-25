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

authoritative_static_projects  = attribute('authoritative_static_projects')
additive_static_projects       = attribute('additive_static_projects')
authoritative_dynamic_projects = attribute('authoritative_dynamic_projects')
additive_dynamic_projects      = attribute('additive_dynamic_projects')

# Member groupings
member_groups = [
  attribute('member_group_0'),
  attribute('member_group_1')
]

# Projects

control "project-bindings-authoritative-static" do
  title 'Test authoritative static projects bindings are correct'

  describe authoritative_static_projects.map { |project| project_bindings(project) } do
    it 'include the 1st binding' do
      if roles < 1
        skip 'less than 1 roles specified'
      else
        should all include role: 'roles/iam.roleViewer', members: member_groups[0]
      end
    end

    it 'include the 2nd binding' do
      if roles < 2
        skip 'less than 2 roles specified'
      else
        should all include role: 'roles/logging.viewer', members: member_groups[1]
      end
    end

    it 'include the 3rd binding' do
      if roles < 3
        skip 'less than 3 roles specified'
      else
        should all include role: 'roles/iam.securityReviewer', members: member_groups[0]
      end
    end
  end
end

control "project-bindings-additive-static" do
  title 'Test additive static projects bindings are correct'

  describe additive_static_projects.map { |project| project_bindings(project) } do
    it 'include the 1st binding' do
      if roles < 1
        skip 'less than 1 roles specified'
      else
        should all include role: 'roles/iam.roleViewer', members: member_groups[0]
      end
    end

    it 'include the 2nd binding' do
      if roles < 2
        skip 'less than 2 roles specified'
      else
        should all include role: 'roles/logging.viewer', members: member_groups[1]
      end
    end

    it 'include the 3rd binding' do
      if roles < 3
        skip 'less than 3 roles specified'
      else
        should all include role: 'roles/iam.securityReviewer', members: member_groups[0]
      end
    end
  end
end

control "project-bindings-authoritative-dynamic" do
  title 'Test authoritative dynamic projects bindings are correct'

  describe authoritative_dynamic_projects.map { |project| project_bindings(project) } do
    it 'include the 1st binding' do
      if roles < 1
        skip 'less than 1 roles specified'
      else
        should all include role: 'roles/iam.roleViewer', members: member_groups[0]
      end
    end

    it 'include the 2nd binding' do
      if roles < 2
        skip 'less than 2 roles specified'
      else
        should all include role: 'roles/logging.viewer', members: member_groups[1]
      end
    end

    it 'include the 3rd binding' do
      if roles < 3
        skip 'less than 3 roles specified'
      else
        should all include role: 'roles/iam.securityReviewer', members: member_groups[0]
      end
    end
  end
end

control "project-bindings-additive-dynamic" do
  title 'Test additive dynamic projects bindings are correct'

  describe additive_dynamic_projects.map { |project| project_bindings(project) } do
    it 'include the 1st binding' do
      if roles < 1
        skip 'less than 1 roles specified'
      else
        should all include role: 'roles/iam.roleViewer', members: member_groups[0]
      end
    end

    it 'include the 2nd binding' do
      if roles < 2
        skip 'less than 2 roles specified'
      else
        should all include role: 'roles/logging.viewer', members: member_groups[1]
      end
    end

    it 'include the 3rd binding' do
      if roles < 3
        skip 'less than 3 roles specified'
      else
        should all include role: 'roles/iam.securityReviewer', members: member_groups[0]
      end
    end
  end
end
