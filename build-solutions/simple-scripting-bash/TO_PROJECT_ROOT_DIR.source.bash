# shellcheck shell=bash
# shellcheck disable=SC2034

# Path to the project's root directory
# This file defines the TO_PROJECT_ROOT_DIR variable, which let us know where the project root directory locates
# 林博仁 © 2018
## Include Guard to prevent multiple sourcing
if [ -v "TO_PROJECT_ROOT_DIR" ]; then
	return 0
fi

declare TO_PROJECT_ROOT_DIR="../.."

## This script is based on the GNU Bash Shell Script Template project
## https://github.com/Lin-Buo-Ren/GNU-Bash-Shell-Script-Template
## and is based on the following version:
## META_BASED_ON_GNU_BASH_SHELL_SCRIPT_TEMPLATE_VERSION="v2.0.1-2-g877ada8-dirty"
## You may rebase your script to incorporate new features and fixes from the template
