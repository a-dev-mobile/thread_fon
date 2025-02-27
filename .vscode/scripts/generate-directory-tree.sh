#!/bin/bash

# Активируем виртуальное окружение
source /home/dmitriy/.venv/bin/activate

# Аргументы
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/pitch_selection"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/thread_type_selection"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/diameter_selection"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/info"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/imperial_threads"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/metric_threads/tolerance_selection"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/imperial_threads/tolerance_selection"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/imperial_threads/info"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/metric_threads/info"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/metric_threads/info/views"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/"

PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/imperial_threads/tolerance_selection"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/metric_threads/pitch_selection"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/metric_threads/tolerance_selection"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/04_imperial_threads/diameter_selection"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/05_trapezoidal_threads/diameter_selection"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/04_imperial_threads/tolerance_selection"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/05_trapezoidal_threads/tolerance_selection"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/04_imperial_threads/tolerance_selection"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/10_settings"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/04_imperial_threads/info"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/03_metric_threads/info"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/05_trapezoidal_threads/info"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/06_pipe_threads/diameter_selection"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/features/06_pipe_threads"
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/lib/app"
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
OUTPUT_FILE="directory_structure.log"
DISPLAY="all"
DISPLAY="content"

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
