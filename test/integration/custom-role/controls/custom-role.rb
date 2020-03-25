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

# GCP Custom Role

custom_role_id_project = attribute('custom_role_id_project')
custom_role_id_org = attribute('custom_role_id_org')
project_id = attribute('project_id')
org_id = attribute('org_id')

control "GCP Custom Role" do
    title "Custom Role"

    describe command ("gcloud iam roles describe #{custom_role_id_project} --project #{project_id} --format=json") do
        its(:exit_status) { should eq 0 }
        its(:stderr) { should eq '' }

        let!(:data) do
            if subject.exit_status == 0
                JSON.parse(subject.stdout)
            else
                {}
            end
        end

        describe "custom_role" do
            it "have role" do
                expect(data["description"]).to include("This is a project level custom role.")
                expect(data["includedPermissions"]).to include("iam.roles.list")
                expect(data["includedPermissions"]).to include("iam.roles.delete")
            end
        end
    end

    describe command ("gcloud iam roles describe #{custom_role_id_org} --organization #{org_id} --format=json") do
        its(:exit_status) { should eq 0 }
        its(:stderr) { should eq '' }

        let!(:data) do
            if subject.exit_status == 0
                JSON.parse(subject.stdout)
            else
                {}
            end
        end

        describe "custom_role" do
            it "have role" do
                expect(data["description"]).to include("This is an organization level custom role.")
                expect(data["includedPermissions"]).to include("iam.roles.list")
                expect(data["includedPermissions"]).to include("iam.roles.delete")
            end
        end
    end
end
