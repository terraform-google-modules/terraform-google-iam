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

project_id = attribute('project_id')
service_account_email = attribute('service_account_email')

control 'Member IAM check' do
  title "Member IAM check"

  describe command("gcloud projects get-iam-policy #{project_id} --format=json") do
    its('exit_status') { should eq 0 }
    its('stderr') { should eq '' }

    let(:bindings) do
      if subject.exit_status == 0
        JSON.parse(subject.stdout, symbolize_names: true)[:bindings]
      else
        []
      end
    end

    describe "roles/compute.networkUser" do
      it "includes the project service account in the roles/compute.networkAdmin IAM binding" do
        expect(bindings).to include(
                                members: including("serviceAccount:#{service_account_email}"),
                                role: "roles/compute.networkAdmin",
                            )
      end

      it "includes the group email in the roles/appengine.appAdmin IAM binding" do
        expect(bindings).to include(
                                members: including("serviceAccount:#{service_account_email}"),
                                role: "roles/appengine.appAdmin",
                            )
      end

    end
  end
end
