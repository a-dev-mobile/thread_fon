#!/bin/bash

# Путь к исполняемому файлу
EXECUTABLE="/home/dmitriy/Documents/DEV/MY_GITHUB/generate-directory-tree-py/release/generate-directory-tree-latest.linux"

# Аргументы
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon"
FILE_NAMES=(


    "*.dart"
)
EXCLUDE=(
    "*.gen.dart"
    "*.g.dart"
    "*.freezed.dart"
    "android"
    "build"
    "assets"
    ".git"
    ".fvm"
    ".vscode"
    ".dart_tool"
    "obj"
    "bin"
    "windows"
    "linux"
    "macos"
    "ios"
    "github"
    ".idea"
    "web"
    
)
# LOG_FILE="directory_structure.log" # Файл для сохранения лога, если не указан - лог сохраняется в консоль. Если пусто, лог сохраняется в файл по умолчанию в указанной директории.
LOG_LEVEL="INFO"                      # Уровень логирования (допустимые значения: DEBUG, INFO, WARNING, ERROR, CRITICAL)
OUTPUT_FILE="directory_structure.log" # Файл для сохранения вывода, если пусто, сохраняется в файл по умолчанию в указанной директории.
DISPLAY="all"                         # Опции: structure, count, content, all (default: all)
# LOG_FILE="directory_structure.log" # Файл для сохранения лога, если не указан - лог сохраняется в консоль. Если пусто, лог сохраняется в файл по умолчанию в указанной директории.

# Принимаем DISPLAY как аргумент командной строки
# DISPLAY=$1

# Запуск скрипта с аргументами
"$EXECUTABLE" --path "$PROJ_PATH" \
    --file-names "${FILE_NAMES[@]}" \
    --exclude "${EXCLUDE[@]}" \
    --log-level "$LOG_LEVEL" \
    --output-file "$OUTPUT_FILE" \
    --display "$DISPLAY"
#   --log-file "$LOG_FILE" \
