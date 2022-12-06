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
custom_role_id_org_unsupported = attribute('custom_role_id_org_unsupported')
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

        describe "project_custom_role" do
            it "have role" do
                expect(data["description"]).to include("This is a project level custom role.")
                expect(data["includedPermissions"]).to include("iam.roles.list")
                expect(data["includedPermissions"]).to include("iam.roles.delete")
                expect(data["includedPermissions"]).to include("iam.serviceAccounts.list")
                expect(data["includedPermissions"]).to include("iam.serviceAccounts.delete")
                expect(data["includedPermissions"]).not_to include("iam.serviceAccounts.setIamPolicy")
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

        describe "organization_custom_role" do
            it "have role" do
                expect(data["description"]).to include("This is an organization level custom role.")
                expect(data["includedPermissions"]).to include("iam.roles.list")
                expect(data["includedPermissions"]).to include("iam.roles.delete")
                expect(data["includedPermissions"]).to include("iam.serviceAccounts.list")
                expect(data["includedPermissions"]).to include("iam.serviceAccounts.delete")
                expect(data["includedPermissions"]).not_to include("iam.serviceAccounts.setIamPolicy")
            end
        end
    end

    describe command ("gcloud iam roles describe #{custom_role_id_org_unsupported} --organization #{org_id} --format=json") do
        its(:exit_status) { should eq 0 }
        its(:stderr) { should eq '' }

        let!(:data) do
            if subject.exit_status == 0
                JSON.parse(subject.stdout)
            else
                {}
            end
        end

        describe "project_unsupported_custom_role" do
            it "does not have permissions" do
                expect(data["includedPermissions"]).not_to include("gkehub.fleet.get")
            end
        end
    end

    describe command ("gcloud projects get-iam-policy #{project_id} --format=json") do
        its(:exit_status) { should eq 0 }
        its(:stderr) { should eq '' }

        let!(:data) do
            if subject.exit_status == 0
                JSON.parse(subject.stdout)
            else
                {}
            end
        end

        describe "project_custom_role" do
            it "is bound to" do
                transformed_data={}
                data['bindings'].each do |binding|
                    transformed_data.store(binding["role"],binding["members"])
                end
                expect(transformed_data["projects/#{project_id}/roles/#{custom_role_id_project}"]).to include("serviceAccount:custom-role-account-01@#{project_id}.iam.gserviceaccount.com")
            end
        end
    end

    describe command ("gcloud organizations get-iam-policy #{org_id} --format=json") do
        its(:exit_status) { should eq 0 }
        its(:stderr) { should eq '' }

        let!(:data) do
            if subject.exit_status == 0
                JSON.parse(subject.stdout)
            else
                {}
            end
        end

        describe "organization_custom_role" do
            it "is bound to" do
                transformed_data={}
                data['bindings'].each do |binding|
                    transformed_data.store(binding["role"],binding["members"])
                end
                expect(transformed_data["organizations/#{org_id}/roles/#{custom_role_id_org}"]).to include("group:test-gcp-org-admins@test.infra.cft.tips")
            end
        end
    end
end
