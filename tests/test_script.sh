#!/bin/bash
function assertResponse() {
    local testName="${1}"
    local expected="${2}"
    local result="${3}"
    local response="PASS"
    if [[ ${expected} != ${result}]]
    then
    
        echo "${testName}: FAILED"
        echo "   EXPECTED: {expected}"
        echo "   RESULT: {result}"
    else
         echo "${testName}: PASS"
    fi

}



function git() {
    echo """* FA-1
  main
"""
}
source ../src/script.sh


export CODEBUILD_SOURCE_VERSION=refs/heads/main
result=$(getBranch)
expected="main"
assertResponse getBranch_envVar ${expected} ${result}
