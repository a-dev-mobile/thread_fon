#!/bin/bash

# Активируем виртуальное окружение
source /home/dmitriy/.venv/bin/activate

# Аргументы
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon"
FILE_NAMES=(
    "*.dart"
)
EXCLUDE=(

    "localization"
    "*.gen.dart"
    "l10n.dart"
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
EXCLUDE_STRINGS=(
    "import '"
    "part '"
)
LOG_LEVEL="INFO"
OUTPUT_FILE="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/directory_structure.log"  # Полный путь для избежания путаницы
DISPLAY="all"

# Запуск скрипта с аргументами
python /home/dmitriy/Documents/DEV/MY_GITHUB/scripts/scripts/personal/generate_directory_tree.py \
    --path "$PROJ_PATH" \
    --file-names "${FILE_NAMES[@]}" \
    --exclude "${EXCLUDE[@]}" \
    --log-level "$LOG_LEVEL" \
    --display "$DISPLAY" \
    --output-file "$OUTPUT_FILE" \
    --exclude-strings "${EXCLUDE_STRINGS[@]}"  # Новый аргумент для исключаемых подстрок

# Деактивируем виртуальное окружение
deactivate
