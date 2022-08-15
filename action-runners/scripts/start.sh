#!/bin/bash

ORGANIZATION=$ORGANIZATION
ACCESS_TOKEN=$ACCESS_TOKEN
RUNNER_LABEL=$RUNNER_LABEL

# Get runner registration token
REG_TOKEN=$(curl \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: token ${ACCESS_TOKEN}" \
  https://api.github.com/orgs/${ORGANIZATION}/actions/runners/registration-token | jq .token --raw-output)

# Configure runner
cd /home/actions-runner
./config.sh --url https://github.com/${GH_OWNER} --token ${REG_TOKEN} --labels ${RUNNER_LABEL}

# Process runner removal
cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
