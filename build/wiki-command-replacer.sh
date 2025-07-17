#!/usr/bin/env bash

set -eu -o pipefail

cd "$(dirname "$0")/.."

MARKER_START='{{COMMAND-OUTPUT "'
MARKER_END='"}}'
ALLOWED_COMMANDS=("phpcs" "phpcbf")
DEFAULT_OPTIONS=("--parallel=1" "--no-cache" "--no-colors" "--report-width=100" "--report=diff")

tokenize_command() {
  read -ra TOKENS <<< "$1"
}

check_allowed_commands() {
  local cmd="${TOKENS[0]}"
  for allowed in "${ALLOWED_COMMANDS[@]}"; do
    [[ "${cmd}" == "${allowed}" ]] && return 0
  done

  echo >&2 "  ERROR: refusing to run arbitrary command: ${cmd}"
  exit 1
}

validate_tokens() {
  for token in "${TOKENS[@]}"; do
    if [[ "${token}" =~ [\;\|\&\$\<\>\`\\] ]]; then
      echo >&2 "  ERROR: refusing unsafe token: ${token}"
      exit 1
    fi
  done
}

add_default_options() {
  EXECUTABLE_COMMAND=("${TOKENS[0]}" "${DEFAULT_OPTIONS[@]}" "${TOKENS[@]:1}")
}

execute_command() {
  tokenize_command "$1"
  check_allowed_commands
  validate_tokens
  add_default_options

  echo >&2 "  INFO: running: " "${EXECUTABLE_COMMAND[@]}"
  read -ra executable <<<"${EXECUTABLE_COMMAND[@]}"
  "${executable[@]}"
}

if [[ -z "${CI:-}" ]]; then
  # The `_wiki` directory is created in a previous GitHub Action step.
  # This 'if' block is intended to assist with local development activity.
  rm -rf _wiki/
  cp -r wiki/ _wiki/
fi

grep -lrF "${MARKER_START}" _wiki | while read -r file_to_process; do
  echo "Processing markers in ${file_to_process}"

  while IFS=$'\n' read -r line; do
    if [[ ${line} = ${MARKER_START}*${MARKER_END} ]]; then
      USER_COMMAND="${line##"${MARKER_START}"}"
      USER_COMMAND="${USER_COMMAND%%"${MARKER_END}"}"

      # shellcheck disable=SC2310
      execute_command "${USER_COMMAND}" </dev/null || true
    else
      echo "${line}"
    fi
  done < "${file_to_process}" > build/temp.md

  mv build/temp.md "${file_to_process}"
done
