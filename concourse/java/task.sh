#!/bin/sh
# we don't to anything with the artifact yet - we just want to build it.
set -ueo pipefail

export GREEN='\033[1;32m'
export NC='\033[0m'
export CHECK="√"
export M2_LOCAL_REPO=".m2"


mvn -f source/pom.xml install

mv source/target/herokupipe-example-0.0.1-SNAPSHOT.jar jar-file/app.jar
mv source/Dockerfile jar-file/Dockerfile

echo -e "${GREEN}${CHECK} Maven install${NC}"
