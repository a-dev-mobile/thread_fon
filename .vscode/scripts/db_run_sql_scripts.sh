#!/bin/bash
# SCRIPT_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/scripts/db_run_sql_scripts.sh" && chmod +x $SCRIPT_PATH && $SCRIPT_PATH

# Прерывать выполнение при любой ошибке
set -e

# Переменные подключения
DB_NAME="dev_thread_db"
#
DB_USER="postgres"
export PGPASSWORD="v5dIY8UaX28kpkf6o6ZhoTAPYT6MYcaKxRh9Zg7dwZQfNEXI8c"
DB_HOST="134.255.232.136"
DB_PORT="5432"


# Массив с полными путями к SQL-файлам
SQL_FILES=(
    # /home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/scripts/FUNCTION/get_diameters.sql
    # /home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/scripts/FUNCTION/get_pitch.sql
    # /home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/scripts/FUNCTION/get_tolerance.sql
    /home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/.vscode/scripts/FUNCTION/get_info.sql

)

# Проверка существования базы данных
database_exists() {
    # Подключаемся  template1 вместо postgres
    psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d template1 -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'" | grep -q 1
}

# Проверка существования базы данных
echo "Проверка существования базы данных $DB_NAME..."
if database_exists; then
    echo "База данных $DB_NAME уже существует."
else
    echo "Создание базы данных $DB_NAME..."
    if createdb -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" "$DB_NAME"; then
        echo "База данных $DB_NAME успешно создана."
    else
        echo "Ошибка при создании базы данных $DB_NAME." >&2
        exit 1
    fi
fi

# Выполнение SQL-файлов
for sql_file in "${SQL_FILES[@]}"; do
    echo "Выполнение скрипта $sql_file..."
    if psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -f "$sql_file"; then
        echo "Скрипт $sql_file выполнен успешно."
    else
        echo "Ошибка при выполнении скрипта $sql_file." >&2
        exit 1
    fi
done

# Очистка переменной PGPASSWORD для безопасности
unset PGPASSWORD
