info "Backing up Nextcloud"
info "Turning on maintenance mode for Nextcloud..."
docker exec --user www-data nextcloud php occ maintenance:mode --on > /dev/null
info "Creating backup of the nextcloud configs..."
7z a "${BACKUP_PATH}"/nextcloud.7z /srv/nextcloud/config > /dev/null && EXIT_CODE=$? || EXIT_CODE=$?
if [ "$EXIT_CODE" != 0 ]; then
	err "Failed to create a backup for Nextcloud!"
fi
info "Turning off maintenance mode for Nextcloud..."
docker exec --user www-data nextcloud php occ maintenance:mode --off > /dev/null