#!/bin/bash

set -e
set -u
set -o pipefail

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# A list of required environment variables that have to
# be exported prior to executing this script.
REQUIRED=(
    # Needed to log in
    # to dockerhub
    # and push the image
    DOCKERHUB_USERNAME
    DOCKERHUB_PASSWORD
    DOCKERHUB_REPOSITORY
    DOCKERHUB_TAG
)

# Check if environment variables are present and non-empty.
for v in ${REQUIRED[@]}; do
    eval VALUE='$'${v}
    if [[ -z $VALUE ]]; then
        echo "The '$v' environment variable has to be set, aborting..."
        exit 1
    fi
done

# Build the image
docker build .

# Get the image id
DOCKER_IMAGE_ID=$(docker images | grep jenkins | grep 2.32.3 | awk '{print $3}')
echo ${DOCKER_IMAGE_ID}

# Tag the image locally
docker tag ${DOCKER_IMAGE_ID} ${DOCKERHUB_USERNAME}/${DOCKERHUB_REPOSITORY}:${DOCKERHUB_TAG}

# Login to docker hub registry
docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}

# Push the image to registry
docker push ${DOCKERHUB_USERNAME}/${DOCKERHUB_REPOSITORY}
