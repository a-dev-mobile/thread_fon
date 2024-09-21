#!/bin/bash
# SCRIPT_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_app/.vscode/scripts/generate_commit_prompt.sh" && chmod +x $SCRIPT_PATH && $SCRIPT_PATH
# Путь к Python-скрипту
PYTHON_SCRIPT="/home/dmitriy/Documents/DEV/MY_GITHUB/scripts/scripts/personal/generate_commit_prompt.py"

# Путь к проекту
PROJECT_PATH="/home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/"

# Язык (русский) и максимальная длина сообщения (по умолчанию 50)
LANGUAGE="ru"
MAX_LENGTH=50

# Путь к виртуальному окружению (если оно создано)
VENV_PATH="/home/dmitriy/.venv"

# Проверка, существует ли виртуальное окружение
if [ -d "$VENV_PATH" ]; then
    # Активируем виртуальное окружение
    source "$VENV_PATH/bin/activate"
    echo "Виртуальное окружение активировано."
else
    echo "Виртуальное окружение не найдено, используем глобальное окружение Python."
fi

# Запуск Python-скрипта с передачей параметров
python3 "$PYTHON_SCRIPT" --language "$LANGUAGE" --max-length "$MAX_LENGTH" --path "$PROJECT_PATH"

# Деактивация виртуального окружения, если оно было активировано
if [ -d "$VENV_PATH" ]; then
    deactivate
    echo "Виртуальное окружение деактивировано."
fi
