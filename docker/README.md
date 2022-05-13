# Docker Playbook

This playbooks deploys and mangages the server stack for reitz.dev

The containers needed as well as the default user can be set in: `group_vars/all.yml`.
If a role is added and the container name is different than the role name, or more than one containers are defined, please add the names of the container to `additional_containers`.

And example for a configuration file of the host can be found in : `host_vars/example.yml`

Before running `ansible-galaxy collection install` needs to be called

## Playbook: 01_deploy_single.yml

Deploys only a single role

### extra_vars arguments 
| Syntax      | Description |
| ----------- | ----------- |
| serivce=Name   | Deploys the given service |


### Examples: 
`ansible-playbook 01_deploy_single.yml -e=service=NAME --ask-vault-pass`

## Playbook: 90_remove.yml

Stops and deletes containers created by Ansible.

### extra_vars arguments 
| Syntax      | Description |
| ----------- | ----------- |
| only_stop=1       | Only stops the containers |
| container=Name1   | Removes/Stops only the given Container |
| {"containers":["Name1", "Name2"]}   | Removes/Stops only the given Containers |
| remove_images=1   | Removes all images **!Warning!** Removes images not used by ansible as well |


### Examples: 
`ansible-playbook 90_remove.yml --extra-vars="only_stop=1"` \
`ansible-playbook 90_remove.yml --extra-vars '{"containers":["Name1", "Name2"]}'` \
`ansible-playbook 90_remove.yml --e=container=Name1 --ask-vault-pass`


## Playbook: 10_setup_backup.yml

The backup will be created at 1 every night on the server and will be downloaded from there at 2.

### Backup Retrival

For the Storage Server: Setup all the variables in `group_vars/all.yml`. Warning! The backup auto delete, deletes any file older than the given date in the folder `backups`. Please do not store other files there.

### Create new Backup-Job

To create a Backup for your service you can create a script in `backup/templates/scripts` with the same name as the service. It will be automatically transfered to the server when `10_setup_backup.yml` is called. In your Script use the `${BACKUP_PATH}` as the path to save the backup. For Logging use: `ok`, `info`, `error` as prefix.