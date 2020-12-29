#!/bin/bash
set -euo pipefail

curl -LO "https://raw.githubusercontent.com/rebeagle/ok.sh/master/ok.sh"
chmod +x "ok.sh"

IFS=/ read REPO_OWNER REPO_NAME <<< ${GITHUB_REPOSITORY}

ARTIFACT_ID=$(./ok.sh list_workflow_run_artifacts "${REPO_OWNER}" "${REPO_NAME}" "${RUN_ID}" \
    | awk '($2 == "ubuntu-vm"){ print $1 }')

if [[ -z $ARTIFACT_ID ]]; then
    echo "Could not locate 'ubuntu-vm' artifact for run '${RUN_ID}' in '${GITHUB_REPOSITORY}'."
    exit 1
fi

./ok.sh download_workflow_run_artifact "${REPO_OWNER}" "${REPO_NAME}" "${ARTIFACT_ID}" > ubuntu-vm.zip

INFO=$(curl -H "Accept: application/vnd.github.v3+json" "https://api.github.com/repos/${GITHUB_REPOSITORY}/actions/runs/${RUN_ID}")
RELEASE=$(jq -r '.head_sha[0:12]+"-"+(.created_at | gsub("[-:]";""))' <<< $info)
echo "::set-output name=release_name::$RELEASE"
