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

# Billing Bindings

billing_iam_test_accounts = attribute('billing_iam_test_accounts')
project_id = attribute('project_id')

control "GCP Billing IAM" do
            title "GCP Billing Bindings"
            billing_iam_test_accounts.each do |billing_iam_test_accounts|
                describe command ("gcloud beta billing accounts get-iam-policy #{billing_iam_test_accounts} --format=json") do
                its(:exit_status) { should eq 0 }
                its(:stderr) { should eq '' }

                let!(:data) do
                    if subject.exit_status == 0
                        JSON.parse(subject.stdout)
                    else
                        {}
                    end
                end

                describe "members" do
                it "are bound" do
                    transformed_data={}
                    data['bindings'].each do |binding|
                        transformed_data.store(binding["role"],binding["members"])
                    end
                    expect(transformed_data["roles/billing.viewer"]).to include("serviceAccount:billing-iam-test-01@#{project_id}.iam.gserviceaccount.com")
                    expect(transformed_data["roles/billing.admin"]).to include("serviceAccount:billing-iam-test-01@#{project_id}.iam.gserviceaccount.com")
                    expect(transformed_data["roles/billing.admin"]).to include("serviceAccount:billing-iam-test-02@#{project_id}.iam.gserviceaccount.com")
                end
            end
        end
    end
end
