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

# Resource pairs (arrays of length = 2)
projects         = attribute('projects')

# Member groupings
groups = [
  attribute('member_group_0')
]

# Projects

control 'project-bindings' do
  title 'Test projects bindings are correct'

  for project in [projects[0]] do
    describe project_bindings(project) do
      it { should include role: 'roles/iam.roleViewer', members: groups[0] }
      # it { should include role: 'roles/logging.viewer', members: groups[0] }
      # it { should include role: 'roles/iam.securityReviewer', members: groups[0] }
    end
  end
end
