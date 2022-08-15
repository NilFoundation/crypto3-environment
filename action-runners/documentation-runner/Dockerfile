FROM ghcr.io/nilfoundation/crypto3-environment/environment

ARG DOXYGEN_VERSION=1_9_1

WORKDIR /home

ARG RUNNER_VERSION=2.294.0

LABEL RunnerVersion=${RUNNER_VERSION}

# Add additional packages
RUN apt-get install -y --no-install-recommends git curl jq

# Install doxygen
RUN apt-get install -y --no-install-recommends flex bison graphviz texlive-latex-extra
RUN git clone https://github.com/doxygen/doxygen.git
RUN cd doxygen && git checkout Release_${DOXYGEN_VERSION} && mkdir build && cd build && cmake -G "Unix Makefiles" .. && make && make install

# Install actions runner
RUN cd /home && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

RUN /home/actions-runner/bin/installdependencies.sh

# Add entrypoint
ADD ../scripts/start.sh start.sh

RUN chmod +x start.sh

ENV RUNNER_ALLOW_RUNASROOT=1

ENTRYPOINT ["./start.sh"]
