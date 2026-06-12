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

# Function to evaluate Maven expression
eval_expression() {
  mvn help:evaluate -Dexpression=$1 -q -DforceStdout 2>&1 | grep -v "^\[" | grep -v "^WARNING"
}

# Get project information from pom.xml
PROJECT_VERSION=$(eval_expression "project.version")
PROJECT_GROUP_ID=$(eval_expression "project.groupId")
PROJECT_ARTIFACT_ID=$(eval_expression "project.artifactId")
REPOSITORY_ID=$(eval_expression "project.distributionManagement.repository.id")
REPOSITORY_URL=$(eval_expression "project.distributionManagement.repository.url")
PROJECT_PACKAGING=$(eval_expression "project.packaging")

echo "--------"
echo "Deploying: ${PROJECT_GROUP_ID}:${PROJECT_ARTIFACT_ID}:${PROJECT_VERSION}"

mvn -q deploy:deploy-file -DgroupId=${PROJECT_GROUP_ID} \
  -DartifactId=${PROJECT_ARTIFACT_ID} -Dversion=${PROJECT_VERSION} -Dpackaging=${PROJECT_PACKAGING} -Dfile=target/${PROJECT_ARTIFACT_ID}-${PROJECT_VERSION}.${PROJECT_PACKAGING} -DrepositoryId=${REPOSITORY_ID} -Durl=${REPOSITORY_URL}