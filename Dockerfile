FROM metabrainz/base-image:jammy-1.0.4-v0.1

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get upgrade -o Dpkg::Options::="--force-confold" -y && \
    apt-get install --no-install-recommends -y rsync && \
    rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN useradd --create-home --shell /bin/bash --uid 6060 brainz && \
    echo 'brainz:brainz' | chpasswd

COPY sshd.service /etc/service/sshd/run
RUN rm /etc/service/sshd/down
