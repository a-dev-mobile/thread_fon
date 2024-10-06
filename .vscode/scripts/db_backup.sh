#!/bin/bash
# SCRIPT_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/scripts/db_backup.sh" && chmod +x $SCRIPT_PATH && $SCRIPT_PATH install


# для выбора версии pg_dump
#export PATH="/usr/lib/postgresql/16/bin:$PATH"
#VERSION_CHOICE= "16"
export PATH="/usr/lib/postgresql/17/bin:$PATH"
VERSION_CHOICE="17"


# SCRIPT_PATH="/home/dmitriy/Documents/DEV/WORK/mts/projects/supapp/microservices/apianalysis/.vscode/scripts/backup_db.sh" && chmod +x $SCRIPT_PATH && $SCRIPT_PATH install
# Переменные для подключения к базе данных
DUMP_DIR="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/backup"  # Путь до каталога, где будет сохраняться дамп

DB_NAME="dev_thread_db"
DB_USER="postgres"

export PGPASSWORD="v5dIY8UaX28kpkf6o6ZhoTAPYT6MYcaKxRh9Zg7dwZQfNEXI8c"
DB_HOST="134.255.232.136"
DB_PORT="5432"

DATE=$(date +"%Y-%m-%d_%H-%M-%S")  # Метка времени
DUMP_FILE="${DUMP_DIR}/backup_${DB_NAME}_${DATE}_pg${VERSION_CHOICE}.sql"

# Убедитесь, что папка для бэкапов существует
mkdir -p "$DUMP_DIR"

# Снятие дампа базы данных с помощью pg_dump с исключением владельцев и привилегий
pg_dump -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" --no-owner --no-acl "$DB_NAME" > "$DUMP_FILE"

# Проверка успешности снятия дампа
if [ $? -eq 0 ]; then
  echo "Дамп базы данных $DB_NAME успешно создан: $DUMP_FILE"
else
  echo "Ошибка создания дампа базы данных $DB_NAME"
  exit 1
fi