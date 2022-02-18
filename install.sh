#!/usr/bin/bash
set -e
export DEBIAN_FRONTEND="noninteractive"

# Functions.
run_command() {
    if ! ${@}; then
        echo "ERROR: '${@}' didn't run succesfully."
        exit 1
    fi
}

# Make sure we're running under root.
if [[ "$(whoami)" != "root" && "${IGNORE_SUDO:+x}" != "x" ]]; then
    echo "This script needs to be run as the root user in order to function properly."
    echo "If you're sure this isn't an issue, set the 'IGNORE_SUDO' environment variable and run the script again."
    exit 1
fi

# Install needed dependencies.
if ! command -v curl 1> /dev/null; then
    echo "INFO: Installing curl..."
    run_command apt-get install curl -y
fi

# Download and install file.
temp_file="$(mktemp '/tmp/tmp.XXXXXXXXXX.deb')"

echo "INFO: Downloading latest release..."
run_command curl -L 'https://github.com/hwittenborn/ci-utils/releases/latest/download/ci-utils.deb' -o "${temp_file}"

echo "INFO: Installing package..."
run_command apt-get install "${temp_file}" -y
