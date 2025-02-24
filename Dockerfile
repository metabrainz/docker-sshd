FROM metabrainz/base-image:jammy-1.0.4-v0.1

RUN apt-get update && \
    apt-get install -y rsync

RUN useradd --create-home --shell /bin/bash --uid 6060 brainz && \
    echo 'brainz:brainz' | chpasswd

COPY sshd.service /etc/service/sshd/run
RUN rm /etc/service/sshd/down
