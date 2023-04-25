SCRIPT_PATH=$(dirname $(realpath -s $0))

DOCKER_IMG=simoll/llvm_workshop:demyst

docker pull ${DOCKER_IMG}

docker run \
    --rm -i -t \
    --net=host \
    -v ${SCRIPT_PATH}:/home/${USER}/llvm_demyst \
    -w /home/${USER}/llvm_demyst \
    -e USER_UID=`id -u` \
    -e USER_GID=`id -g` \
    -e USER_NAME=${USER} \
    ${DOCKER_IMG}
