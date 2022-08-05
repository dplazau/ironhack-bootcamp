#!/bin/bash

. $(pwd)/scripts/config.sh

echo "checking if ${DEV_CONTAINER_NAME} is already build"
docker container ls -a | grep "${DEV_CONTAINER_NAME}"
ret=$?

if [ ${ret} -eq 1 ]; then
    echo "setup ${DEV_CONTAINER_NAME}"
    #docker rm -f ${DEV_CONTAINER_NAME}
    docker build . -t "${DEV_IMG}"
    docker run -d=true --name "${DEV_CONTAINER_NAME}" -itv "${LOCAL_APP_PATH}:${CONTAINER_PATH}" "${DEV_IMG}"
else
    exit 1
fi

exit 0
