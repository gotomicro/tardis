#!/bin/bash

# WARNING: DO NOT EDIT, THIS FILE IS PROBABLY A COPY
#
# The original version of this file is located in the https://github.com/istio/common-files repo.
# If you're looking at this file in a different repo and want to make a change, please go to the
# common-files repo, make the change there and check it in. Then come back to this repo and run
# "make update-common".

# Copyright Istio Authors
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
APP_NAME=${1:?"app name"}

if BUILD_GIT_REVISION=$(git rev-parse HEAD 2> /dev/null); then
  if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
    BUILD_GIT_REVISION=${BUILD_GIT_REVISION}"-dirty"
  fi
else
  BUILD_GIT_REVISION=unknown
fi

# Check for local changes
if git diff-index --quiet HEAD --; then
  tree_status="Clean"
else
  tree_status="Modified"
fi

# XXX This needs to be updated to accomodate tags added after building, rather than prior to builds
GIT_DESCRIBE_TAG=$(git describe --tags)

# security wanted VERSION='unknown'
VERSION="${BUILD_GIT_REVISION}"
if [[ -n "${GIT_DESCRIBE_TAG}" ]]; then
  VERSION="${GIT_DESCRIBE_TAG}"
fi

APP_PKG=${2:?"app pkg"}
# used by scripts/build/gobuild.sh
echo "${APP_PKG}/cmd/version.buildVersion=${VERSION}"
echo "${APP_PKG}/cmd/version.buildGitVersion=${BUILD_GIT_REVISION}"
echo "${APP_PKG}/cmd/version.buildTag=${GIT_DESCRIBE_TAG}"
echo "${APP_PKG}/cmd/version.buildStatus=${tree_status}"
echo "${APP_PKG}/cmd/version.buildUser=$(whoami)"
echo "${APP_PKG}/cmd/version.buildHost=$(hostname -f)"
echo "${APP_PKG}/cmd/version.buildTime=$(date '+%Y-%m-%d--%T')"


