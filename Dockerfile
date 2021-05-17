FROM debian:buster-slim
LABEL maintainer="Takashi Makimoto <mackie@beehive-dev.com>"

ARG RUNNER_VERSION="2.278.0"
ARG USER=action
ARG GROUP=action
ARG UID=1000
ARG GID=1000
ARG PASS=password

RUN \
     apt-get update -y && \
     apt-get upgrade -y && \
     apt-get install -y curl git git-lfs jq rsync sudo && \
     groupadd -g "$GID" "$GROUP" && \
     useradd -m -s /bin/bash -u "$UID" -g "$GID" "$USER" && \
     usermod -aG sudo "$USER" && \
     echo "${USER}:${PASS}" | chpasswd && \
     mkdir "/home/${USER}/actions-runner" && \
     cd "/home/${USER}/actions-runner" && \
     curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
     tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
     chown -R "${USER}:${GROUP}" "/home/${USER}" && \
     ./bin/installdependencies.sh

COPY bootstrap.sh /home/${USER}/bootstrap.sh
RUN  chmod +x /home/${USER}/bootstrap.sh

USER "$USER"
WORKDIR "/home/${USER}"

ENTRYPOINT ["./bootstrap.sh"]
