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

mvn deploy
[[ $? -ne 0 ]] && exit 1

