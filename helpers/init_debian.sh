#!/bin/bash
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


# ####################################### #
#   VARIABLES FOR SETUP THE ENVIRONMENT   #
#    Please modify the variables below    #
#        according to your system         #
# ####################################### #

# Where almost all the downloads are performed
HOME=$HOME

# Arquitecture of your linux dist. (for terraform)
LINUXARQ="linux_amd64"
# Terraform installation path
TERRAFORM_HOME="$HOME/terraform"
# Terraform version
TERRAFORM_VERSION="0.10.8"
# Terraform plugins path
TERRAFORM_PLUGINS_PATH="$HOME/.terraform.d/plugins"

# URL to bats repo
BATS_REPO="https://github.com/sstephenson/bats.git"
# Folder to install bats
BATS_HOME="/opt/bats"

# ####################################### #
#         Basic tool installation         #
# ####################################### #
sudo apt-get -y update
sudo apt-get -y install build-essential
sudo apt-get -y install wget
sudo apt-get -y install curl
sudo apt-get -y install git-core
sudo apt-get -y install unzip
sudo apt-get -y install jq

# ####################################### #
#         Terraform Installation          #
# ####################################### #
sudo mkdir -p "$TERRAFORM_HOME"
cd "$TERRAFORM_HOME" || exit
#shellcheck disable=SC2153
yes | sudo wget "https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_$TERRAFORM_VERSION_$LINUXARQ.zip"
yes | sudo unzip terraform_"$TERRAFORM_VERSION"_"$LINUXARQ".zip*
sudo rm -f terraform_"$TERRAFORM_VERSION"_"$LINUXARQ".zip*

export TERRAFORM_HOME=$TERRAFORM_HOME

# ####################################### #
#      Environment variables setup        #
# ####################################### #

export PATH="$PATH:$TERRAFORM_HOME"

sudo touch /etc/profile.d/environment.sh
sudo chown "$(whoami)" /etc/profile.d/environment.sh
cat <<EOF | sudo tee /etc/profile.d/environment.sh
#!/bin/bash

export PATH="$PATH:$TERRAFORM_HOME:/usr/local/bin"

EOF

# ####################################### #
#         PLUGINS INSTALLATION            #
# ####################################### #

# ####################################### #
#        Google SDK Installation          #
# ####################################### #

# Create an environment variable for the correct distribution
CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
export CLOUD_SDK_REPO

# Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Update the package list and install the Cloud SDK
sudo apt-get update -y && sudo apt-get install -y google-cloud-sdk

 ####################################### #
        Bats  installation               #
 ####################################### #

sudo rm -rf $BATS_HOME/*
sudo mkdir -p $BATS_HOME
cd $BATS_HOME || exit
sudo git clone $BATS_REPO
cd bats/ || exit
sudo ./install.sh /usr/local

export PATH="$PATH:/usr/local/bin"

# ####################################### #
#                   INFO                  #
# ####################################### #

echo "Terraform installed on $TERRAFORM_HOME/"
echo "Terraform version: $(terraform -version)"
echo "Bats version: $(bats)"
echo "Terraform plugins: $(ls -l "$TERRAFORM_PLUGINS_PATH")"
echo "gcloud version: $(gcloud version)"
