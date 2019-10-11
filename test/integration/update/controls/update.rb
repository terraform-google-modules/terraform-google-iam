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

project_groups = [
  # Resource pairs (arrays of length = 2)
  attribute('authoritative_static_projects'),
  attribute('additive_static_projects'),
  attribute('authoritative_dynamic_projects'),
  attribute('additive_dynamic_projects')
]

# Member groupings
member_groups = [
  attribute('member_group_0'),
  attribute('member_group_1')
]

# Projects

for projects in project_groups do
  control "project-bindings-#{projects}" do
    title 'Test projects bindings are correct'

    for project in projects do
      describe project_bindings(project) do
        it { should include role: 'roles/iam.roleViewer', members: member_groups[0] }
        it { should include role: 'roles/logging.viewer', members: member_groups[1] }

        # Uncomment the following line to test the addition of 3rd role
        # it { should include role: 'roles/iam.securityReviewer', members: member_groups[0] }
      end
    end
  end
end
