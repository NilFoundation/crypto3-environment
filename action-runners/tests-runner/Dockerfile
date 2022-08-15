FROM ghcr.io/nilfoundation/crypto3-environment/environment

WORKDIR /home

ARG RUNNER_VERSION=2.294.0

LABEL RunnerVersion=${RUNNER_VERSION}

# Add additional packages
RUN apt-get install -y --no-install-recommends git curl jq

# Install runner
RUN cd /home && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN /home/actions-runner/bin/installdependencies.sh

# Add entrypoint
ADD ../scripts/start.sh start.sh

RUN chmod +x start.sh

ENV RUNNER_ALLOW_RUNASROOT=1

ENTRYPOINT ["./start.sh"]
