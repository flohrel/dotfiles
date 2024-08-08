#!/bin/bash

# -e: exit on error
# -u: exit on unset variables
set -eu

if ! chezmoi="$(command -v chezmoi)"; then
	bin_dir="${HOME}/.local/bin"
	chezmoi="${bin_dir}/chezmoi"
	echo "Installing chezmoi to '${chezmoi}'" >&2
	if command -v curl >/dev/null; then
		chezmoi_install_script="$(curl -fsSL https://chezmoi.io/get)"
	elif command -v wget >/dev/null; then
		chezmoi_install_script="$(wget -qO- https://chezmoi.io/get)"
	else
		echo "To install chezmoi, you must have curl or wget installed." >&2
		exit 1
	fi
	sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
	unset chezmoi_install_script bin_dir
fi

SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}")"            # relative
SCRIPT_DIR="$(cd -- "$SCRIPT_DIR" && pwd)"    # absolutized and normalized
if [[ -z "$SCRIPT_DIR" ]] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi

set -- init --apply --source="${SCRIPT_DIR}"

echo "Running 'chezmoi $*'" >&2
# exec: replace current process with chezmoi
exec "$chezmoi" "$@"
