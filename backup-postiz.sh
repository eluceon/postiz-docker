#!/bin/bash
set -e

BACKUP_DIR="/backup/postiz"
DATE=$(date +%Y%m%d_%H%M%S)
ENV_FILE="$HOME/postiz-docker/.env"

if [ -f "$ENV_FILE" ]; then
    export $(grep -v '^#' $ENV_FILE | xargs)
else
    echo "Error: .env file not found at $ENV_FILE"
    exit 1
fi

mkdir -p ${BACKUP_DIR}

docker exec postiz-postgres pg_dump -U ${POSTIZ_DB_USER} ${POSTIZ_DB} | gzip > ${BACKUP_DIR}/postiz_db_${DATE}.sql.gz

docker run --rm \
  -v postiz-config:/source-config:ro \
  -v postiz-uploads:/source-uploads:ro \
  -v ${BACKUP_DIR}:/backup \
  alpine \
  sh -c "tar czf /backup/postiz_config_${DATE}.tar.gz -C /source-config . && tar czf /backup/postiz_uploads_${DATE}.tar.gz -C /source-uploads ."

find ${BACKUP_DIR} -type f -mtime +7 -delete

echo "Backup completed: ${DATE}"
