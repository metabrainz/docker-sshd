#!/usr/bin/env bash
#
# Build image running an SSH daemon with RSync (and rrsync command) available
# and push it to the Docker Hub, tagged with date and build number.
#
# Usage:
#   $ ./push.sh

set -e -o pipefail -u

DOCKER_CMD=${DOCKER_CMD:-docker}

cd "$(dirname "${BASH_SOURCE[0]}")"

image_name='metabrainz/sshd'

datestamp=$(date -u +"%Y-%m-%d")
timestamp=$(date -u +"%H:%M:%SZ")
vcs_ref=$(git describe --always --broken --dirty --tags)

date_version="v-${datestamp}"
build_number=$(${DOCKER_CMD} images "image_name" | grep -c "${date_version}" || [[ $? -eq 1 ]])
image_tag="${date_version}.${build_number}"

${DOCKER_CMD} build \
  --build-arg BUILD_DATE="${datestamp}T${timestamp}" \
  --build-arg VCS_REF="${vcs_ref}" \
  --no-cache \
  --tag "${image_name}:${image_tag}" . \
  2>&1 | tee ./"build-${image_tag}-at-${timestamp}.log"

${DOCKER_CMD} push "${image_name}:${image_tag}" \
  2>&1 | tee -a ./"build-${image_tag}-at-${timestamp}.log"

# vi: set et sts=2 sw=2 ts=2 :
