#!/bin/sh

set -x

cd /usr/share/nginx/html/

sed -i \
  -e "s:\${HOSTNAME}:${HOSTNAME}:g" \
  -e "s:\${OPENSHIFT_BUILD_NAME}:${OPENSHIFT_BUILD_NAME}:g" \
  -e "s:\${OPENSHIFT_BUILD_NAMESPACE}:${OPENSHIFT_BUILD_NAMESPACE}:g" \
  -e "s:\${OPENSHIFT_BUILD_SOURCE}:${OPENSHIFT_BUILD_SOURCE}:g" \
  -e "s:\${OPENSHIFT_BUILD_COMMIT}:${OPENSHIFT_BUILD_COMMIT}:g" index.html

exec "${@}"
