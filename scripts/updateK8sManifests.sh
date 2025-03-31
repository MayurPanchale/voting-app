#!/bin/bash

# Convert Windows line endings to Unix line endings
sed -i 's/\r//g' /home/azureuser/myagent/_work/2/s/scripts/updateK8sManifests.sh

set -x

# Set the repository URL
REPO_URL="
https://53rP8JX2FEA6ZsmSaItzWp5CboUhxn8IIzx7flJoy8RBXphHexrYJQQJ99BCACAAAAAAAAAAAAASAZDO28yD@dev.azure.com/mayurdevopsorg/voting-app/_git/voting-app"

# Clone the git repository into the /tmp directory
git clone "$REPO_URL" /tmp/temp_repo

# Navigate into the cloned repository directory
cd /tmp/temp_repo

# Make changes to the Kubernetes manifest file(s)
# For example, let's say you want to change the image tag in a deployment.yaml file
sed -i "s|image:.*|image: mayurazurecicd.azurecr.io/$2:$3|g" k8s-specifications/$1-deployment.yaml

# Add the modified files
git add .

# Commit the changes
git commit -m "Update Kubernetes manifest"

# Push the changes back to the repository
git push origin main

# Cleanup: remove the temporary directory
rm -rf /tmp/temp_repo
