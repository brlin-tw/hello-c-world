#!/usr/bin/env bash
# shellcheck disable=SC2034

# Script to install the software system or to a installation prefix specified by --prefix
# 林博仁 © 2018

## Makes debuggers' life easier - Unofficial Bash Strict Mode
## BASHDOC: Shell Builtin Commands - Modifying Shell Behavior - The Set Builtin
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

## Non-overridable Primitive Variables
## BASHDOC: Shell Variables » Bash Variables
## BASHDOC: Basic Shell Features » Shell Parameters » Special Parameters
if [ -v 'BASH_SOURCE[0]' ]; then
	RUNTIME_EXECUTABLE_PATH="$(realpath --strip "${BASH_SOURCE[0]}")"
	RUNTIME_EXECUTABLE_FILENAME="$(basename "${RUNTIME_EXECUTABLE_PATH}")"
	RUNTIME_EXECUTABLE_NAME="${RUNTIME_EXECUTABLE_FILENAME%.*}"
	RUNTIME_EXECUTABLE_DIRECTORY="$(dirname "${RUNTIME_EXECUTABLE_PATH}")"
	RUNTIME_COMMANDLINE_BASECOMMAND="${0}"
	declare -r\
		RUNTIME_EXECUTABLE_FILENAME\
		RUNTIME_EXECUTABLE_DIRECTORY\
		RUNTIME_EXECUTABLE_PATHABSOLUTE\
		RUNTIME_COMMANDLINE_BASECOMMAND
fi
declare -ar RUNTIME_COMMANDLINE_PARAMETERS=("${@}")

## init function: entrypoint of main program
## This function is called near the end of the file,
## with the script's command-line parameters as arguments
init(){
	local installation_prefix=''

	if ! process_commandline_parameters\
		installation_prefix; then
		printf\
			'Error: %s: Invalid command-line parameters.\n'\
			"${FUNCNAME[0]}"\
			1>&2
		print_help
		exit 1
	fi

	if [ -z "${installation_prefix}" ]; then
		installation_prefix=/usr/local
	fi

	# Read where is the project's root directory
	# shellcheck source=/dev/null
	source "${RUNTIME_EXECUTABLE_DIRECTORY}/TO_PROJECT_ROOT_DIR.source.bash"

	local project_root_dir;
	project_root_dir="$(realpath "${RUNTIME_EXECUTABLE_DIRECTORY}/${TO_PROJECT_ROOT_DIR}")"; local -r project_root_dir

	declare -r exe_dir="${RUNTIME_EXECUTABLE_DIRECTORY}/executables"
	declare -r gettext_dir="${project_root_dir}/internationalization-solutions/gnu-gettext"

	# Install executable
	mkdir\
		--parents\
		"${installation_prefix}/bin"
	install\
		"${exe_dir}/hello-c-world"\
		"${installation_prefix}/bin"

	# Install localization
	"${gettext_dir}/install-localizations.bash" \
		"${installation_prefix}"

	# Install documents

	printf --\
		'%s\n'\
		'Installation finished.'

	exit 0
}; declare -fr init

## Traps: Functions that are triggered when certain condition occurred
## Shell Builtin Commands » Bourne Shell Builtins » trap
trap_errexit(){
	printf 'An error occurred and the script is prematurely aborted\n' 1>&2
	return 0
}; declare -fr trap_errexit; trap trap_errexit ERR

trap_exit(){
	return 0
}; declare -fr trap_exit; trap trap_exit EXIT

trap_return(){
	local returning_function="${1}"

	printf 'DEBUG: %s: returning from %s\n' "${FUNCNAME[0]}" "${returning_function}" 1>&2
}; declare -fr trap_return

trap_interrupt(){
	printf '\n' # Separate previous output
	printf 'Recieved SIGINT, script is interrupted.' 1>&2
	return 1
}; declare -fr trap_interrupt; trap trap_interrupt INT

print_help(){
	# Backticks in help message is Markdown's <code> markup
	# shellcheck disable=SC2016
	{
		printf '# Help Information for %s #\n' \
			"${RUNTIME_COMMANDLINE_BASECOMMAND}"
		printf '## SYNOPSIS ##\n'
		printf '* `"%s" _command-line_options_`\n\n' \
			"${RUNTIME_COMMANDLINE_BASECOMMAND}"

		printf '## COMMAND-LINE OPTIONS ##\n'
		printf '### `-h` / `--help` ###\n'
		printf 'Print this message\n\n'

		printf '### `-d` / `--debug` ###\n'
		printf 'Enable script debugging\n\n'

		printf '### `-p` / `--prefix` <prefixdir> ###\n'
		printf 'Specify installation prefix directory(default: /usr/local)\n\n'

	}
	return 0
}; declare -fr print_help;

process_commandline_parameters() {
	declare -n installation_prefix_ref="$1"; shift 1

	if [ "${#RUNTIME_COMMANDLINE_PARAMETERS[@]}" -eq 0 ]; then
		return 0
	fi

	# modifyable parameters for parsing by consuming
	local -a parameters=("${RUNTIME_COMMANDLINE_PARAMETERS[@]}")

	# Normally we won't want debug traces to appear during parameter parsing, so we  add this flag and defer it activation till returning(Y: Do debug)
	local enable_debug=N

	while true; do
		if [ "${#parameters[@]}" -eq 0 ]; then
			break
		else
			case "${parameters[0]}" in
				--help\
				|-h)
					print_help;
					exit 0
					;;
				--debug\
				|-d)
					enable_debug="Y"
					;;
				--prefix\
				|-p)
					if [ "${#parameters[@]}" -eq 1 ]; then
						printf --\
							'ERROR: --prefix requires 1 argument.\n'
						return 1
					fi
					installation_prefix_ref="${parameters[1]}"
					# shift array by 1 = unset 1st then repack
					unset "parameters[0]"
					if [ "${#parameters[@]}" -ne 0 ]; then
						parameters=("${parameters[@]}")
					fi
					;;
				*)
					printf --\
						'ERROR: Unknown command-line argument "%s"\n'\
						"${parameters[0]}"\
						>&2
					return 1
					;;
			esac
			# shift array by 1 = unset 1st then repack
			unset "parameters[0]"
			if [ "${#parameters[@]}" -ne 0 ]; then
				parameters=("${parameters[@]}")
			fi
		fi
	done

	if [ "${enable_debug}" = "Y" ]; then
		trap 'trap_return "${FUNCNAME[0]}"' RETURN
		set -o xtrace
	fi
	return 0
}; declare -fr process_commandline_parameters;

init "${@}"

## This script is based on the GNU Bash Shell Script Template project
## https://github.com/Lin-Buo-Ren/GNU-Bash-Shell-Script-Template
## and is based on the following version:
## META_BASED_ON_GNU_BASH_SHELL_SCRIPT_TEMPLATE_VERSION="v2.0.1-2-g877ada8-dirty"
## You may rebase your script to incorporate new features and fixes from the template
