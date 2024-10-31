#!/bin/bash

JUNIT_OUTPUT=true
JUNIT_FILE=junit-output.xml


function assertResponse() {
    local testName="${1}"
    local expected="${2}"
    local result="${3}"
    local response="PASS"

    if [[ ${expected} != ${result} ]]
    then
        echo "${testName}: FAILED"
        echo "   EXPECTED: ${expected}"
        echo "   RESULT: ${result}"
        if [[ "${JUNIT_OUTPUT}" == "true" ]]
        then
            echo "<testcase classname=\"${testName}\" name=\"${testName}\">" >> ${JUNIT_FILE}
            echo "<failure message=\"FAILED\" type=\"error\">EXPECTED: ${expected}" >> ${JUNIT_FILE}
            echo "RESULT: ${result}</failure>" >> ${JUNIT_FILE}
            echo "</testcase>" >> ${JUNIT_FILE}
        fi

    else
        if [[ "${JUNIT_OUTPUT}" == "true" ]]
        then
            echo "<testcase classname=\"${testName}\" name=\"${testName}\"/>" >> ${JUNIT_FILE}
        fi
        echo "${testName}: PASS"
    fi
}


function createJUnitHeader() {
    if [[ "${JUNIT_OUTPUT}" == "true" ]]
    then
        local numberOfTests=$(cat tests/test_script.sh| grep assertResponse | grep -v "#.*assertResponse" | grep -v "function assertResponse" | wc -l | tr -d " ")
        echo "<testsuite tests=\"${numberOfTests}\">" > ${JUNIT_FILE}
    fi
}
function createJUnitFooter() {
    if [[ "${JUNIT_OUTPUT}" == "true" ]]
    then
        echo "</testsuite>" >> ${JUNIT_FILE}
    fi
}

createJUnitHeader


export CODEBUILD_SOURCE_VERSION="refs/heads/main"

source src/script.sh

result=$(getBranch)
expected="main"
assertResponse getBranch_envVar ${expected} ${result} true

unset CODEBUILD_SOURCE_VERSION
result=$(getBranch)
expected="FA-1"
assertResponse getBranch_envVar ${expected} ${result} true

createJUnitFooter

