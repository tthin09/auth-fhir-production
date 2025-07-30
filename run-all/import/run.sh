docker compose up id-db -d
docker cp id-backup.sql run-all-id-db-1:/id-backup.sql
docker exec -it run-all-id-db-1 bash

pg_restore -U admin_temporary -d postgres /id-backup.sql
exit