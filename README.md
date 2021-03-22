Take the postgresql image, add restic to it and finish it off with a bash script and some env variables and you get a nice way to back up arbitrary postgresql databases to a restic repo

## Config

Configuration for DB and Restic can be achieved through these environment variables:

| Env Name          | Description    | Examples  |
| ----------        | -------------- | --------- |
| DBHOST            | Hostname of the postgresql. This corresponds to the container name of the DB-Container | e.g. postgresql |
| DBUSER            | Username for the DB to be backed up. |           |
| DBPASSWORD        | Password for the DB to be backed up. |           |
| DBNAME            | Database name.  |           |
| DUMP              | File name of the sql dump file. | backup.sql |
| RESTIC_REPOSITORY | Target Repository where the backup should be stored to. (Any type Restic supports) |           |
| RESTIC_PASSWORD   | Password to the given Restic Repository. |           |
| UID               | Numeric representation of the UID that should own the created dump and execute the restic backup. | e.g. 1000 |



There are no default values behind these variables, you have to provide all  of them!

For the values and meanings of the RESTIC_* variables and other variables you may have to set check out the [Restic Docs](https://restic.readthedocs.io/en/latest/040_backup.html#environment-variables)

## Other stuff

- This image has ssh/sftp installed to make use of sftp as repository targets. In order to make headless, Host Key Verification is disabled. **Only use ssh/sftp servers that you really trust**

- You can set a full path for file as well however, working outside of /opt or /tmp will most likely cause problems with non-existing directories

- You can use local repositores with restic as well. In this case you have to mount the container as well. Just make sure that DUMP and the repository don't occupy the same directory in the container.

- This image is published on docker hub under `hochri/restic_postgres_backup`
