#!/bin/bash
# Первый скрипт
# SCRIPT_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/scripts/db_run_sql_scripts.sh" && chmod +x $SCRIPT_PATH && $SCRIPT_PATH


# full 
# SCRIPT_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/scripts/db_run_sql_scripts.sh" && chmod +x $SCRIPT_PATH && $SCRIPT_PATH && SCRIPT_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/scripts/FUNCTION/get_info.sh" && chmod +x $SCRIPT_PATH && $SCRIPT_PATH

DB_NAME="dev_thread_db"

# Переменные для подключения к базе данных
DB_USER="readonly_user"
export PGPASSWORD="123123"
DB_HOST="134.255.232.136"
DB_PORT="5432"

echo ""
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "SELECT * FROM metric.get_info(122, 'm', '7g6g');"
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "SELECT * FROM metric.get_info(123, 'f', '4H');"
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "SELECT * FROM metric.get_info(70, 'm', '4g');"
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "SELECT * FROM metric.get_info(70, 'm', '6g');"
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "SELECT * FROM metric.get_info(70, 'm', '6h');"
echo ""

