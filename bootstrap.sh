#!/bin/sh

set -x

cd /usr/share/nginx/html/

sed -i -e "s:\${HOSTNAME}:${HOSTNAME}:g" index.html
sed -i -e "s:\${OPENSHIFT_BUILD_NAME}:${OPENSHIFT_BUILD_NAME}:g" index.html
sed -i -e "s:\${OPENSHIFT_BUILD_NAMESPACE}:${OPENSHIFT_BUILD_NAMESPACE}:g" index.html
sed -i -e "s#\${OPENSHIFT_BUILD_SOURCE}#${OPENSHIFT_BUILD_SOURCE}#g" index.html
sed -i -e "s:\${OPENSHIFT_BUILD_COMMIT}:${OPENSHIFT_BUILD_COMMIT}:g" index.html

exec "${@}"
