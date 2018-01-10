#/usr/bin/env bash
#
# copy over the appropriate files to SOURCES/esgrep-${VERSION}.tar.gz
# 
set -e
cd $(dirname ${BASH_SOURCE[0]})

VERSION=$(awk '/^Version:/ {print $NF}' SPECS/esgrep.spec)
FULL_VERSION=${VERSION}-$(awk -F'[[:space:]%]' '/^Release:/ {print $2}' SPECS/esgrep.spec)

mkdir ./SOURCES/esgrep-${VERSION}
cp ../bin/esgrep ./SOURCES/esgrep-${VERSION}/
cp ../config/esgrep.yml ./SOURCES/esgrep-${VERSION}/
tar czf ./SOURCES/esgrep-${FULL_VERSION}.tar.gz -C ./SOURCES/ esgrep-${VERSION}/
rm -r ./SOURCES/esgrep-${VERSION}/
