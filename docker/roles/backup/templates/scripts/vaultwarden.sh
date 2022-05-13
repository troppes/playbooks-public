info "Backing up Vaultwarden"
info "Creating zipped archive of Vaultwarden..."
7z a "${BACKUP_PATH}"/vaultwarden.7z /srv/vaultwarden/ > /dev/null && EXIT_CODE=$? || EXIT_CODE=$?
if [ "$EXIT_CODE" != 0 ]; then
	err "Failed to create a backup for Vaultwarden!"
fi