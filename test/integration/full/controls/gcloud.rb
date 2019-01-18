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

credentials_file_path = attribute('credentials_file_path')

memberGroups = [
  attribute('member_group_0'),
  attribute('member_group_1')
]

folders = attribute('folders')
projects = attribute('projects')

basicRoles = attribute('basic_roles')
projectRoles = attribute('project_roles')

ENV['CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE'] = credentials_file_path

def assertBindings(name, cmd, ids, roles, mbrGrps)
  control "#{name}-bindings" do
    ids.each_with_index do |id, i|
      describe command(sprintf(cmd, id)) do
        its('exit_status') { should eq 0 }
        its('stderr') { should eq '' }
  
        let(:members) do
          bindings = JSON.parse(subject.stdout, symbolize_names: true)[:bindings]
          bindings.find { |b| b[:'role'] == roles[i] }[:members]
        end
  
        it { expect(members).to include(*mbrGrps[i]) }
      end
    end
  end
end

assertBindings('folder',
    "gcloud beta resource-manager folders get-iam-policy %s --format='json(bindings)'",
    folders, basicRoles, memberGroups)

assertBindings('project',
    "gcloud projects get-iam-policy %s --format='json(bindings)'",
    projects, projectRoles, memberGroups)
