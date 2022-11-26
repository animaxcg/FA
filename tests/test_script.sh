#!/bin/bash
function assertResponse() {
    local testName="${1}"
    local expected="${2}"
    local result="${3}"
    local response="PASS"
    if [[ ${expected} != ${result} ]]
    then
        # echo "${testName}: FAILED"
        # echo "   EXPECTED: ${expected}"
        # echo "   RESULT: ${result}"
        echo "<testcase classname=\"${testName}\" name=\"${testName}\">"
        echo "</testcase>"

    else
        echo "<testcase classname=\"${testName}\" name=\"${testName}\"/>"
        #  echo "${testName}: PASS"
    fi
}


# function parseJunitResults() {

# }
numberOfTests=$(cat tests/test_script.sh| grep assertResponse | grep -v "#.*assertResponse" | grep -v "function assertResponse" | wc -l | tr -d " ")
echo "<testsuite tests=\"${numberOfTests}\">"

# function git() {
#     echo """* FA-1
#   main
# """
# }
export CODEBUILD_SOURCE_VERSION="refs/heads/main"

source src/script.sh

result=$(getBranch)
expected="main"
assertResponse getBranch_envVar ${expected} ${result}

unset CODEBUILD_SOURCE_VERSION
result=$(getBranch)
expected="FA-1"
assertResponse getBranch_envVar ${expected} ${result}



echo "</testsuite>"