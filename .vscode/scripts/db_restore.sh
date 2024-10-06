#!/bin/bash

# Скрипт для восстановления базы данных из дампа с другим именем
# SCRIPT_PATH="/home/dmitriy/Documents/DEV/WORK/mts/projects/supapp/microservices/apianalysis/.vscode/scripts/restore_db.sh" && chmod +x $SCRIPT_PATH && $SCRIPT_PATH install


# имя базы данных
DB_NAME="thread_db"


# Переменные для подключения к базе данных
DB_USER="postgres"
export PGPASSWORD="v5dIY8UaX28kpkf6o6ZhoTAPYT6MYcaKxRh9Zg7dwZQfNEXI8c"
DB_HOST="134.255.232.136"
DB_PORT="5432"


# выбрать дамп
DUMP_FILE='/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/backup/backup_dev_thread_db_2024-10-06_08-03-28_pg17.sql'

# Проверка существования дампа
if [ ! -f "$DUMP_FILE" ]; then
  echo "Файл дампа не найден: $DUMP_FILE"
  exit 1
fi

echo "Используется дамп: $DUMP_FILE"

# Создание новой базы данных на основе template0
createdb -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -T template0 "$DB_NAME"

if [ $? -eq 0 ]; then
  echo "База данных '$DB_NAME' успешно создана."
else
  echo "Ошибка создания базы данных '$DB_NAME'. Возможно, база уже существует или недостаточно прав."
  exit 1
fi

# Восстановление дампа в новую базу данных
psql -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -f "$DUMP_FILE"

if [ $? -eq 0 ]; then
  echo "Дамп успешно восстановлен в базу данных '$DB_NAME'."
else
  echo "Ошибка восстановления дампа в базу данных '$DB_NAME'."
  exit 1
fi
