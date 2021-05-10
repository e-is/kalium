#/bin/bash

SCRIPT_DIR=$(dirname "$(readlink "$BASH_SOURCE" || echo "$BASH_SOURCE")")
PROJECT_DIR=$(cd "${SCRIPT_DIR}/.." && pwd -P)
export PROJECT_DIR

cd $PROJECT_DIR

# Override with a local file, if any
if [[ -f "${PROJECT_DIR}/.local/env.sh" ]]; then
  echo "Loading environment variables from: '.local/env.sh'"
  . ${PROJECT_DIR}/.local/env.sh
else
  echo "No file '${PROJECT_DIR}/.local/env.sh' found. Will use defaults"
fi


mvn deploy
[[ $? -ne 0 ]] && exit 1

