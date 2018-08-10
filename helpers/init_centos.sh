#!/bin/bash
# Copyright 2018 Google LLC
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
sudo yum -y install wget
sudo yum -y install curl
sudo yum -y install git
sudo yum -y install unzip
sudo yum -y install epel-release
sudo yum -y install epel-release
sudo yum -y install jq
sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# ####################################### #
#         Terraform Installation          #
# ####################################### #
sudo mkdir -p $TERRAFORM_HOME
cd $TERRAFORM_HOME

yes | sudo wget "https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_"$TERRAFORM_VERSION"_"$LINUXARQ".zip"
yes | sudo unzip "terraform_"$TERRAFORM_VERSION"_"$LINUXARQ".zip*"
sudo rm -f terraform_"$TERRAFORM_VERSION"_"$LINUXARQ".zip*

export TERRAFORM_HOME=$TERRAFORM_HOME

# ####################################### #
#      Environment variables setup        #
# ####################################### #

export PATH="$PATH:$TERRAFORM_HOME"

sudo touch /etc/profile.d/environment.sh
sudo chown $(whoami) /etc/profile.d/environment.sh
sudo cat <<EOF > /etc/profile.d/environment.sh
#!/bin/bash

export PATH="$PATH:$TERRAFORM_HOME:/usr/local/bin"

EOF

# ####################################### #
#         PLUGINS INSTALLATION            #
# ####################################### #

# ####################################### #
#        Google SDK Installation          #
# ####################################### #

sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM

sudo yum -y install google-cloud-sdk

# ####################################### #
#        Bats  installation               #
# ####################################### #

sudo rm -rf $BATS_HOME/*
sudo mkdir -p $BATS_HOME
cd $BATS_HOME
sudo git clone $BATS_REPO
cd bats/
sudo ./install.sh /usr/local

export PATH="$PATH:/usr/local/bin"

# ####################################### #
#                   INFO                  #
# ####################################### #

echo "Terraform installed on $TERRAFORM_HOME/"
echo "Terraform version: $(terraform -version)"
echo "Bats version: $(bats)"
echo "gcloud version: $(gcloud version)"
