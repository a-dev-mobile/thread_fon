#!/bin/bash
# Первый скрипт
# SCRIPT_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/scripts/db_run_sql_scripts.sh" && chmod +x $SCRIPT_PATH && $SCRIPT_PATH


# full 
# SCRIPT_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/scripts/db_run_sql_scripts.sh" && chmod +x $SCRIPT_PATH && $SCRIPT_PATH && SCRIPT_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/scripts/FUNCTION/update_or_insert_thread.sh" && chmod +x $SCRIPT_PATH && $SCRIPT_PATH

DB_NAME="dev_thread_db"
DB_USER="readonly_user"



export PGPASSWORD="123123"
DB_HOST="134.255.232.136"
DB_PORT="5432"


# DB_USER="postgres"
# export PGPASSWORD="v5dIY8UaX28kpkf6o6ZhoTAPYT6MYcaKxRh9Zg7dwZQfNEXI8c"


echo ""
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c "SET TRANSACTION READ WRITE; SELECT analytics.update_or_insert_thread('M10');"
echo ""

