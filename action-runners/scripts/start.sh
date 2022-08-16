#!/bin/bash

ORGANIZATION=$ORGANIZATION
REG_TOKEN=$REG_TOKEN
RUNNER_LABEL=$RUNNER_LABEL

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
