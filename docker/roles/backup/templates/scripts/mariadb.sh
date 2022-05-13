info "Backing up MariaDB"
docker exec mariadb /usr/bin/mysqldump --all-databases --single-transaction --quick --lock-tables=false > "${BACKUP_PATH}"/mariadb-full-backup-"$(date +%F)".sql -u{{ backup_mariadb_username | string}} -p{{ backup_mariadb_password | string}} && EXIT_CODE=$? || EXIT_CODE=$?
if [ "$EXIT_CODE" != 0 ]; then
	err "Failed to create a backup for MariaDB!"
fi