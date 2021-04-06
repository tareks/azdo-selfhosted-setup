#!/bin/bash

# Meant to be used with AzDo managed VMSS agent pools.
# https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/scale-set-agents?view=azure-devops
# 
# Includes: docker, azure-cli, powershell
# TODO: default to python 3, azure powershell, latest terraform

# Setup Docker with a supported script 
curl -sL https://raw.githubusercontent.com/docker/docker-install/master/install.sh | sh

# Docker post-install
useradd -m AzDevOps
usermod -aG docker AzDevOps

# Install azure-cli
curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install other packages
# Powershell: https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7#ubuntu-1804
apt-get update
apt-get install -y wget apt-transport-https unzip
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
apt-get install -y apt-transport-https
apt-get update
add-apt-repository universe
apt-get install -y powershell dotnet-sdk-5.0 dotnet-sdk-3.1 jq


# Install Az Powershell module..
pwsh -c "Install-Module -Name Az -scope AllUsers -Repository PSGallery -Force"
