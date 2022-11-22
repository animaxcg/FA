#!/bin/bash
function getBranch() {
    if [[ -z ${CODEBUILD_SOURCE_VERSION} ]]
    then
        echo "${CODEBUILD_SOURCE_VERSION}" | awk -F "/" '{print $NF}'
    else
        git branch | grep \* | awk '{print $NF}'
    fi

}

