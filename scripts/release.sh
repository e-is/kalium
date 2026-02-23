#!/bin/bash

# Get to the root project
if [[ "_" == "_${PROJECT_DIR}" ]]; then
  SCRIPT_DIR=$(dirname $0)
  PROJECT_DIR=$(cd "${SCRIPT_DIR}/.." && pwd)
  export PROJECT_DIR
fi;

# Override with a local file, if any
if [[ -f "${PROJECT_DIR}/.local/env.sh" ]]; then
  source ${PROJECT_DIR}/.local/env.sh
else
  echo "No file '${PROJECT_DIR}/.local/env.sh' found. Will use defaults"
fi;

cd ${PROJECT_DIR}

if [[ "_" == "_${RELEASE_OPTS}" ]]; then
  echo "Please configure env RELEASE_OPTS with -Dgpg.keyname=<YOUR_GPG_KEYNAME>"
  exit 1
fi;


# Try to sign artifacts
#mvn install -DskipTests -Prelease-sign-artifacts ${RELEASE_OPTS}
#[[ $? -ne 0 ]] && exit 1

# Prepare release
mvn release:prepare -Darguments="${RELEASE_OPTS}"
[[ $? -ne 0 ]] && exit 1

# Perform release
mvn release:perform
[[ $? -ne 0 ]] && exit 1

