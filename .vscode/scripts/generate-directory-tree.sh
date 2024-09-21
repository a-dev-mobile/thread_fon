#!/bin/bash

# Путь к исполняемому файлу
EXECUTABLE="/home/dmitriy/Documents/DEV/MY_GITHUB/generate-directory-tree-py/release/generate-directory-tree-latest.linux"

# Аргументы
PROJ_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_app/"
FILE_NAMES=(
    # "app.dart"

    # "main.dart"
    # "initialization.dart"
    # "initialize_dependencies.dart"
    # "settings_scope.dart"
    # "dependencies.dart"
    # "error_util.dart"
    # "dependencies.dart"
    # "inherited_dependencies.dart"
    # "initialization_splash_screen.dart"

    # "page_provider.dart"
    # "route_paths.dart"
    # "app_route_information_parser.dart"
    # "app_router_delegate.dart"
    # "page_route_config.dart"

    # "local_storage.dart"

    # "home_screen.dart"

    # "overlay_widget.dart"
    # "debug_btn.dart"
    # "overlay_draggable_button.dart"

    # "app_controller.dart"
    # "app_state.dart"
    # "app_env.dart"
    # "app_controller_scope.dart"

    # "authentication_controller.dart"
    # "authentication_state.dart"
    # "authentication_repository.dart"
    # "user.dart"
    # "sign_in_data.dart"
    # "signup_screen.dart"

    # "metric_thread_type_screen.dart"
    # "metric_thread_diameter_screen.dart"

    # "user_profile_model.dart"
    # "user_profile_bloc.dart"
    # "user_profile_route.dart"
    # "user_profile_screen.dart"

    "*.dart"
)
EXCLUDE=(
    "*.gen.dart"
    "*.g.dart"
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
