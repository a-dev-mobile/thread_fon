#!/bin/bash
# Первый скрипт
# SCRIPT_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/scripts/db_run_sql_scripts.sh" && chmod +x $SCRIPT_PATH && $SCRIPT_PATH


# full SCRIPT_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/scripts/db_run_sql_scripts.sh" && chmod +x $SCRIPT_PATH && $SCRIPT_PATH && SCRIPT_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/scripts/FUNCTION/get_pitch.sh" && chmod +x $SCRIPT_PATH && $SCRIPT_PATH

DB_NAME="dev_thread_db"

# Переменные для подключения к базе данных
DB_USER="postgres"
export PGPASSWORD="v5dIY8UaX28kpkf6o6ZhoTAPYT6MYcaKxRh9Zg7dwZQfNEXI8c"
DB_HOST="134.255.232.136"
DB_PORT="5432"

echo "--"
echo "metric.get_pitch(10, 'en');"
echo ""
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "SELECT * FROM metric.get_pitch(10.0, 'en');"
echo "--"
echo "metric.get_pitch(10, 'ru');"
echo ""
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "SELECT * FROM metric.get_pitch(10.0, 'ru');"