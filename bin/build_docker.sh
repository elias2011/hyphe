#!/bin/bash

### Variables
images_prefix="hyphe_"
organization="scpomedialab"

tag=$1
if test -z "$tag"; then
  tag="latest"
fi

### Misc

displayError(){
    echo -e "\\033[31mERROR: $1 \\033[0m"
    exit $2
}

echoBlue(){
    echo -e "\\033[34m $1 \\033[0m"
}

DOCKER="$(which docker)"
if [ ! $? == 0 ]; then exit 1; fi

$DOCKER version >/dev/null && echoBlue "Docker command Ok" || displayError "Verify that you have sufficient privileges to run docker commands." 1


### Build Memory Structure dependencies

if [ -d $(pwd)/memory_structure/ ]; then
    echoBlue "Building JAVA API with Thrift..."
    $DOCKER run -t -i --rm -v "$(pwd)/memory_structure:/memory_structure" jrisp/thrift:0.8.0 thrift --verbose --out /memory_structure/src/main/java/ --gen java /memory_structure/src/main/java/memorystructure.thrift 
    if [ ! $? == 0 ]; then exit 3; fi
    echoBlue "Compiling Lucene project"
    $DOCKER run -t -i --rm -v "$(pwd)/memory_structure:/memory_structure" -w /memory_structure maven:3.2-jdk-7 mvn -Dmaven.test.skip=true clean install
    if [ ! $? == 0 ]; then exit 3; fi
    echoBlue "Building Python API with Thrift"
    $DOCKER run -t -i --rm -v "$(pwd)/memory_structure:/memory_structure" jrisp/thrift:0.8.0 thrift --verbose --out /memory_structure --gen py /memory_structure/src/main/java/memorystructure.thrift
    if [ ! $? == 0 ]; then exit 3; fi
else
   displayError "Can't find memory_structure folder, are you in project's root directory ?" 2
fi

### Build Backend
echoBlue "Building Hyphe Backend"
$DOCKER build -t $organization/$images_prefix"backend":$tag .  
if [ ! $? == 0 ]; then exit 4; fi

### Build Frontend
echoBlue "Building Hyphe Frontend"
$DOCKER build -t $organization/$images_prefix"frontend":$tag hyphe_frontend 
if [ ! $? == 0 ]; then exit 4; fi

### Build Backend
echoBlue "Building Hyphe Crawler"
$DOCKER build -t $organization/$images_prefix"crawler":$tag -f hyphe_backend/crawler/Dockerfile .
if [ ! $? == 0 ]; then exit 4; fi
 

echoBlue "Build process finished! Now you can run \"docker-compose up\" or pull images to Docker Hub."

