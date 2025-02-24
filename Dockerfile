FROM metabrainz/base-image

RUN apt-get update && \
    apt-get install -y rsync

RUN useradd --create-home --shell /bin/bash --uid 6060 brainz && \
    echo 'brainz:brainz' | chpasswd

COPY sshd.service /etc/service/sshd/run
RUN rm /etc/service/sshd/down
