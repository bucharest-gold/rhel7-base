#!/bin/bash
#
# The 'run' performs a simple test that verifies that STI image.
# The main focus is that the image prints out the base-usage properly.
#
test_docker_run_usage() {
	echo "Testing 'docker run' usage..."
	docker run --rm bucharestgold/rhel7-base:latest &>/dev/null
}

check_result() {
	local result="$1"
	if [[ "$result" != "0" ]]; then
		echo "Image bucharestgold/rhel7-base:latest test FAILED (exit code: ${result})"
		exit $result
	fi
}

# Verify the 'usage' script is working properly when running the base image with 'docker run ...'
test_docker_run_usage
check_result $?