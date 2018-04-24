#!/usr/bin/env bash
# shellcheck disable=SC2034

# Script to build the software
# 林博仁 © 2018

for critical_command in \
	basename\
	dirname\
	realpath
	do
	if ! command -v "${critical_command}" &> /dev/null; then
		echo 'Fatal: This program requires GNU Coreutils in the executable search path'
		exit 1
	fi
done

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
	if ! process_commandline_parameters; then
		printf\
			'Error: %s: Invalid command-line parameters.\n'\
			"${FUNCNAME[0]}"\
			1>&2
		print_help
		exit 1
	fi

	if ! check_runtime_dependencies; then
		exit 1
	fi

	# Read where is the project's root directory
	source "${RUNTIME_EXECUTABLE_DIRECTORY}/TO_PROJECT_ROOT_DIR.source.bash"

	declare project_root_dir; project_root_dir="$(realpath "${RUNTIME_EXECUTABLE_DIRECTORY}/${TO_PROJECT_ROOT_DIR}")"

	declare -r exe_dir="${RUNTIME_EXECUTABLE_DIRECTORY}/executables"
	declare -r object_dir="${RUNTIME_EXECUTABLE_DIRECTORY}/object-code"
	declare -r src_dir="${project_root_dir}/source-code"

	# Compile source code to object code
	printf --\
		'%s\n'\
		'Compiling...'
	gcc\
		-c\
		-o "${object_dir}/hello-c-world.o"\
		"${src_dir}/hello-c-world.c"

	# Link executable
	printf --\
		'%s\n'\
		'Linking...'
	gcc\
		-o "${exe_dir}/hello-c-world"\
		"${object_dir}/hello-c-world.o"

	printf --\
		'Build finished.\n'
	printf --\
		'The built executable is at "%s".\n'\
		"$(realpath --strip --relative-to="${PWD}" "${exe_dir}")"
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
	printf 'Currently no help messages are available for this program\n' 1>&2
	return 0
}; declare -fr print_help;

check_runtime_dependencies(){
	## Runtime Dependencies Checking
	declare\
		runtime_dependency_checking_result='still-pass' \
		required_software

	# Only an item to check for now
	# shellcheck disable=SC2043
	for required_command in \
		gcc
		do
		if ! command -v "${required_command}" &>/dev/null; then
			runtime_dependency_checking_result='fail'

			case "${required_command}" in
				gcc)
					required_software='GCC, the GNU Compiler Collection'
				;;
				*)
					required_software="${required_command}"
				;;
			esac

			printf --\
				"Error: This program requires \"%s\" to be installed and it's executables in the executable searching paths.\\n"\
				"${required_software}" 1>&2
			unset required_software
		fi
	done; unset required_command required_software

	if [ "${runtime_dependency_checking_result}" = 'fail' ]; then
		printf --\
			'Error: Runtime dependency checking fail, the progrom cannot continue.\n' 1>&2
		return 1
	fi; unset runtime_dependency_checking_result
	return 0
}

process_commandline_parameters() {
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
				"--help"\
				|"-h")
					print_help;
					exit 0
					;;
				"--debug"\
				|"-d")
					enable_debug="Y"
					;;
				*)
					printf 'ERROR: Unknown command-line argument "%s"\n' "${parameters[0]}" >&2
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
