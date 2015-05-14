#!/bin/bash
echo "Note: you may need to add your docker-registry to /etc/sysconfig/docker "
echo "(on CentOS/RHEL/Fedora) for this to push to the registries correctly"


if [ -z "$USERNAME" ]; then
    echo "setting USERNAME to " `whoami`
    USERNAME=`whoami`
fi
exit()
if [ -z "$DOCKER_REGISTRY" ]; then
    echo "setting DOCKER_REGISTRY to localhost:5000"
    DOCKER_REGISTRY=localhost:5000
fi
echo "using USERNAME=$USERNAME"
echo "using DOCKER_REGISTRY=$DOCKER_REGISTRY"

BASE_DIR=`pwd`
#build atomicapp-dev-atomicapp  docker container
echo "building atomicapp-dev-atomicapp"
cd atomicapp-dev-atomicapp/
docker build -t $USERNAME/atomicapp-dev-atomicapp  --file="docker-artifacts/Dockerfile" .
docker tag -f $USERNAME/atomicapp-dev-atomicapp  $DOCKER_REGISTRY/atomicapp-dev-atomicapp$TAG
echo "pushing to $DOCKER_REGISTRY/atomicapp-dev-atomicapp$TAG"
echo "y" | docker push $DOCKER_REGISTRY/atomicapp-dev-atomicapp$TAG
echo "build complete: atomicapp-dev-atomicapp"
cd $BASE_DIR

#echo docker build --rm -t $USERNAME/atomicapp-run .
#docker build --rm -t $USERNAME/atomicapp-run .

#doesn't really make sense to run it
#test
#docker run -it --privileged -v /run:/run -v /:/host -v `pwd`:/application-entity $USERNAME/atomicapp-run /bin/bash
#run
#docker run -dt --privileged -v /run:/run -v /:/host -v `pwd`:/application-entity $USERNAME/atomicapp-run
#
