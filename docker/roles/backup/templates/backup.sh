#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

readonly BACKUP_PATH="${SCRIPT_DIR}/backup_files"
readonly LOG_FILE="${SCRIPT_DIR}/backup.log"

function ok() {
  printf '%s [ OK ] %s\n' "$(date --rfc-3339=seconds)" "$@" | tee -a "${LOG_FILE}"
}

# logs info messages to stdout and logfile
function info() {
  printf '%s [INFO] %s\n' "$(date --rfc-3339=seconds)" "$@" | tee -a "${LOG_FILE}"
}

# logs error messages to stdout and logfile
function err() {
  printf '%s [ERR!] %s\n' "$(date --rfc-3339=seconds)" "$@" | tee -a "${LOG_FILE}" >&2
}

#Delete old Backups
info "Deleting old files"

rm "${LOG_FILE}" 2> /dev/null
rm "backup.7z" 2> /dev/null

mkdir -p "${BACKUP_PATH}"

info "Log for $(date "+%Y%m%d")"

info "Starting to backup services"

for file in ${SCRIPT_DIR}/scripts/* ; do
  if [ -f "$file" ] ; then
    . "$file"
  fi
done

info "Finished backup scripts"

info "Zipping backup folder"
7z a  -p"{{ backup_password | string }}" "backup.7z" "${BACKUP_PATH}" > /dev/null && EXIT_CODE=$? || EXIT_CODE=$?
if [ "$EXIT_CODE" != 0 ]; then
	err "Failed to create the archive for all backups!"
fi

info "Deleting TempFolder"
rm -r "${BACKUP_PATH}"

info "Finished Backup for $(date "+%Y%m%d")"
