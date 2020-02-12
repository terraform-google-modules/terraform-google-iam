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

billing_iam_test_account = attribute('billing_iam_test_account')
members = attribute('members')
billing_sa_admin = attribute('billing_sa_admin')

control "GCP Billing IAM" do
            title "GCP Billing Bindings"
            billing_iam_test_account.each do |billing_iam_test_account|
                describe command ("gcloud beta billing accounts get-iam-policy #{billing_iam_test_account} --format=json") do
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
                    members.each_value do |member_value|
                        member_value.each do |member|
                            expect(data['bindings'][0]['members']).to include(member)
                        end
                    end
                end

                describe "Billing IAM SA" do
                it "is bound" do
                    expect(data['bindings'][0]['members']).to include("serviceAccount:#{billing_sa_admin}")
                    end
                end
            end
        end
    end
end
