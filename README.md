# docker-sshd

Docker image for the private `sshd*` services used to export data dumps.

## Usage

It supports the command [`rrsync`](https://download.samba.org/pub/rsync/rrsync.1).

It is restricted to the user/group `brainz` with id `6060`.

The following environment variables can be set at run time:

* `SSHD_LISTEN_ADDRESS`: Change [ListenAddress](https://man.openbsd.org/sshd_config#ListenAddress)
* `SSHD_PORT`: Change [Port](https://man.openbsd.org/sshd_config#Port)

## Maintenance

Since not much changes (beyond `base-image` tag) occur in this repository,
version tracking is mostly achieved through Docker image tags.
See https://hub.docker.com/r/metabrainz/sshd/tags

The script `push.sh` comes in handy here.
