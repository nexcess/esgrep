#!/usr/bin/env bash

if [ -z "$@" ]; then
    EL_RELEASES='7'
else
    EL_RELEASES="$@"
fi

RELEASE=$(grep '^%define esgrep_release' ./rpmbuild/SPECS/esgrep.spec | awk '{print $NF}')
VERSION=$(grep '^%define esgrep_version' ./rpmbuild/SPECS/esgrep.spec | awk '{print $NF}')

echo "$(date) - creating tarball for esgrep-${VERSION}-${RELEASE}"
mkdir ./esgrep-${VERSION}-${RELEASE}/
cp -a ./src/esgrep ./config/esgrep.yml ./esgrep-${VERSION}-${RELEASE}/
tar czf ./esgrep-${VERSION}-${RELEASE}.tar.gz ./esgrep-${VERSION}-${RELEASE}/

echo "$(date) - cleaning up"
rm -r ./esgrep-${VERSION}-${RELEASE}/
mv ./esgrep-${VERSION}-${RELEASE}.tar.gz ./rpmbuild/SOURCES/


for el_release in $EL_RELEASES; do
    mock_config=esgrep-centos-${el_release}-x86_64
    mock_dir=/home/mock/${mock_config}/result

    echo "$(date) - building el${el_release} SRPM"
    sudo mock -v -r ${mock_config} --buildsrpm --spec ./rpmbuild/SPECS/esgrep.spec --source ./rpmbuild/SOURCES/ &> ./rpmbuild/${mock_config}.srpm.log
    if [ -f "${mock_dir}/esgrep-${VERSION}-${RELEASE}.el${el_release}.src.rpm" ]; then
        echo "$(date) - copying el${el_release} SRPM"
        cp -v ${mock_dir}/esgrep-${VERSION}-${RELEASE}.el${el_release}.src.rpm ./rpmbuild/SRPMS/
    else
        echo "$(date) - error building SRPM. Check logs in ${mock_dir}/ or ./rpmbuild/${mock_config}.srpm.log"
        exit 1
    fi

    echo "$(date) - building el${el_release} RPM"
    sudo mock -v -r ${mock_config} ./rpmbuild/SRPMS/esgrep-${VERSION}-${RELEASE}.el${el_release}.src.rpm &> ./rpmbuild/${mock_config}.rpm.log
    if [ -f "${mock_dir}/esgrep-${VERSION}-${RELEASE}.el${el_release}.noarch.rpm" ]; then
        echo "$(date) - copying el${el_release} RPM"
        cp -v ${mock_dir}/esgrep-${VERSION}-${RELEASE}.el${el_release}.noarch.rpm ./rpmbuild/RPMS/
    else
        echo "$(date) - error building RPM. Check logs in ${mock_dir}/ or ./rpmbuild/${mock_config}.rpm.log"
        exit 1
    fi
done
