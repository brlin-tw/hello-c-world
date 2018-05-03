#!/usr/bin/env bash
declare -r PROGRAM_DESCRIPTION='Script to build the software'
declare -r PROGRAM_COPYRIGHT='林博仁 © 2018'

## Makes debuggers' life easier - Unofficial Bash Strict Mode
## BASHDOC: Shell Builtin Commands - Modifying Shell Behavior - The Set Builtin
set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

## Runtime Dependencies Checking
declare\
	runtime_dependency_checking_result=still-pass\
	required_software

for required_command in \
	basename \
	dirname \
	gcc \
	realpath; do
	if ! command -v "${required_command}" &>/dev/null; then
		runtime_dependency_checking_result=fail

		case "${required_command}" in
			basename \
			|dirname \
			|realpath)
				required_software='GNU Coreutils'
				;;
			gcc)
				required_software='GCC, the GNU Compiler Collection'
				;;
			*)
				required_software="${required_command}"
				;;
		esac

		printf -- \
			'Error: This program requires "%s" to be installed and its executables in the executable searching paths.\n' \
			"${required_software}" \
			1>&2
		unset required_software
	fi
done; unset required_command required_software

if [ "${runtime_dependency_checking_result}" = fail ]; then
	printf -- \
		'Error: Runtime dependency checking fail, the progrom cannot continue.\n' \
		1>&2
	exit 1
fi; unset runtime_dependency_checking_result

## Non-overridable Primitive Variables
## BASHDOC: Shell Variables » Bash Variables
## BASHDOC: Basic Shell Features » Shell Parameters » Special Parameters
if [ -v 'BASH_SOURCE[0]' ]; then
	RUNTIME_EXECUTABLE_PATH="$(realpath --strip "${BASH_SOURCE[0]}")"
	RUNTIME_EXECUTABLE_FILENAME="$(basename "${RUNTIME_EXECUTABLE_PATH}")"
	RUNTIME_EXECUTABLE_NAME="${RUNTIME_EXECUTABLE_FILENAME%.*}"
	RUNTIME_EXECUTABLE_DIRECTORY="$(dirname "${RUNTIME_EXECUTABLE_PATH}")"
	RUNTIME_COMMANDLINE_BASECOMMAND="${0}"
	# We intentionally leaves these variables for script developers
	# shellcheck disable=SC2034
	declare -r \
		RUNTIME_EXECUTABLE_PATH \
		RUNTIME_EXECUTABLE_FILENAME \
		RUNTIME_EXECUTABLE_NAME \
		RUNTIME_EXECUTABLE_DIRECTORY \
		RUNTIME_COMMANDLINE_BASECOMMAND
fi
declare -ar RUNTIME_COMMANDLINE_ARGUMENTS=("${@}")

## init function: entrypoint of main program
## This function is called near the end of the file,
## with the script's command-line parameters as arguments
init(){
	if ! process_commandline_arguments; then
		printf -- \
			'Error: Invalid command-line parameters.\n' \
			1>&2

		printf '\n' # separate error message and help message
		print_help
		exit 1
	fi

	# Read where is the project's root directory
	# shellcheck source=/dev/null
	source "${RUNTIME_EXECUTABLE_DIRECTORY}/TO_PROJECT_ROOT_DIR.source.bash"

	declare project_root_dir; project_root_dir="$(realpath "${RUNTIME_EXECUTABLE_DIRECTORY}/${TO_PROJECT_ROOT_DIR}")"

	declare -r exe_dir="${RUNTIME_EXECUTABLE_DIRECTORY}/executables"
	declare -r object_dir="${RUNTIME_EXECUTABLE_DIRECTORY}/object-code"
	declare -r src_dir="${project_root_dir}/source-code"
	declare -r preprocessed_src_dir="${RUNTIME_EXECUTABLE_DIRECTORY}/preprocessed-source-code"
	declare -r assembly_dir="${RUNTIME_EXECUTABLE_DIRECTORY}/assembly-code"
	declare -r gettext_dir="${project_root_dir}/internationalization-solutions/gnu-gettext"

	# Preprocess source code
	printf -- \
		'%s: Preprocessing source code...\n' \
		"${RUNTIME_EXECUTABLE_NAME}"
	gcc \
		-E \
		-o "${preprocessed_src_dir}/hello-c-world.c" \
		"${src_dir}/hello-c-world.c"

	# Compile preprocessed source code to assembly code
	printf -- \
		'%s: Compiling assembly code...\n' \
		"${RUNTIME_EXECUTABLE_NAME}"
	gcc \
		-S \
		-o "${assembly_dir}/hello-c-world.s" \
		"${preprocessed_src_dir}/hello-c-world.c"

	# Assemply assembly code to object code
	printf -- \
		'%s: Assembling object code...\n' \
		"${RUNTIME_EXECUTABLE_NAME}"
	gcc \
		-c \
		-o "${object_dir}/hello-c-world.o" \
		"${assembly_dir}/hello-c-world.s"

	# Link executable
	printf -- \
		'%s: Linking executable...\n' \
		"${RUNTIME_EXECUTABLE_NAME}"
	gcc \
		-o "${exe_dir}/hello-c-world" \
		"${object_dir}/hello-c-world.o"

	printf -- \
		'%s: Building localization...' \
		"${RUNTIME_EXECUTABLE_NAME}"
	"${gettext_dir}/build-localizations.bash"

	printf -- \
		'%s: Build finished.\n' \
		"${RUNTIME_EXECUTABLE_NAME}"
	# COMPATIBILITY: --relative-to is not yet provided by the realpath command from Ubuntu 14.04
	printf -- \
		'%s: The built executable is at "%s".\n' \
		"${RUNTIME_EXECUTABLE_NAME}" \
		"${exe_dir}"
	exit 0
}; declare -fr init

print_help(){
	# Backticks in help message is Markdown's <code> markup
	# shellcheck disable=SC2016
	{
		printf '# Help Information for %s #\n' \
			"${RUNTIME_COMMANDLINE_BASECOMMAND}"
		printf '## PROGRAM DESCRIPTION ##\n'
		printf -- \
			'%s\n\n' \
			"${PROGRAM_DESCRIPTION}"

		printf '## SYNOPSIS ##\n'
		printf '* `"%s" _command-line_options_`\n\n' \
			"${RUNTIME_COMMANDLINE_BASECOMMAND}"

		printf '## COMMAND-LINE OPTIONS ##\n'
		printf '### `-h` / `--help` ###\n'
		printf 'Print this message\n\n'

		printf '### `-d` / `--debug` ###\n'
		printf 'Enable script debugging\n\n'

		printf '## COPYRIGHT ##\n'
		printf -- \
			'%s\n\n' \
			"${PROGRAM_COPYRIGHT}"
	}
}; declare -fr print_help;

process_commandline_arguments() {
	if [ "${#RUNTIME_COMMANDLINE_ARGUMENTS[@]}" -eq 0 ]; then
		return 0
	fi

	# Modifyable parameters for parsing by consuming
	local -a parameters=("${RUNTIME_COMMANDLINE_ARGUMENTS[@]}")

	# Normally we won't want debug traces to appear during parameter parsing, so we add this flag and defer its activation till returning(Y: Do debug)
	local enable_debug=N

	while true; do
		if [ "${#parameters[@]}" -eq 0 ]; then
			break
		else
			case "${parameters[0]}" in
				--help \
				|-h)
					print_help;
					exit 0
					;;
				--debug \
				|-d)
					enable_debug=Y
					;;
				*)
					printf -- \
						'%s: Error: Unknown command-line argument "%s"\n' \
						"${FUNCNAME[0]}" \
						"${parameters[0]}" \
						>&2
					return 1
					;;
			esac
			# shift array by 1 = unset 1st then repack
			unset 'parameters[0]'
			if [ "${#parameters[@]}" -ne 0 ]; then
				parameters=("${parameters[@]}")
			fi
		fi
	done

	if [ "${enable_debug}" = Y ]; then
		trap 'trap_return "${FUNCNAME[0]}"' RETURN
		set -o xtrace
	fi
	return 0
}; declare -fr process_commandline_arguments

## Traps: Functions that are triggered when certain condition occurred
## Shell Builtin Commands » Bourne Shell Builtins » trap
trap_errexit(){
	printf \
		'An error occurred and the script is prematurely aborted\n' \
		1>&2
	return 0
}; declare -fr trap_errexit; trap trap_errexit ERR

trap_exit(){
	return 0
}; declare -fr trap_exit; trap trap_exit EXIT

trap_return(){
	local returning_function="${1}"

	printf \
		'DEBUG: %s: returning from %s\n' \
		"${FUNCNAME[0]}" \
		"${returning_function}" \
		1>&2
}; declare -fr trap_return

trap_interrupt(){
	printf '\n' # Separate previous output
	printf \
		'Recieved SIGINT, script is interrupted.' \
		1>&2
	return 1
}; declare -fr trap_interrupt; trap trap_interrupt INT

init "${@}"

## This script is based on the GNU Bash Shell Script Template project
## https://github.com/Lin-Buo-Ren/GNU-Bash-Shell-Script-Template
## and is based on the following version:
## GNU_BASH_SHELL_SCRIPT_TEMPLATE_VERSION="v3.0.16-1-g9d1ae36"
## You may rebase your script to incorporate new features and fixes from the template
