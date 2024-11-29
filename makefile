# Переменные для использования fvm flutter и fvm dart
FLUTTER := fvm flutter
DART := fvm dart

########################
# Общая помощь
########################

# Задача для получения зависимостей
get:
	$(FLUTTER) pub get

########################
# Очистка
########################

# Задача для очистки предыдущих сборок
clean:
	$(FLUTTER) clean

########################
# Генерация кода
########################

# Задача для сборки с использованием build_runner
gen-build:
	$(DART) run build_runner build --delete-conflicting-outputs --release

# Задача для запуска build_runner в режиме наблюдения
gen-watch:
	$(DART) run build_runner watch --delete-conflicting-outputs --release

########################
# Генерация локализации
########################

# Задача для генерации локализации
gen-localization:
	$(DART) pub global activate intl_utils
	$(DART) pub global run intl_utils:generate

########################
# Исправление и форматирование
########################

# Задача для применения исправлений Dart кода
fix:
	$(DART) fix --apply lib

# Задача для форматирования Dart кода
format:
	$(DART) format --fix .

########################
# Комплексные задачи
########################

# Задача для выполнения всех задач генерации
gen-all: clean get gen-build gen-localization

# Задача для получения всех зависимостей
get-all: clean get

########################
# Сборка Android-приложения
########################

# Создание директории для APK
create-apk-dir:
	@echo "Создание целевой директории, если она не существует..."
	mkdir -p /home/dmitriy/server-spb-my-1-hdd-1tb_1/DEV/APK/thread-fon/

# Копирование APK
copy-apk:
	@echo "Копирование APK-файлов с заменой существующих..."
	cp -f build/app/outputs/flutter-apk/app-*.apk /home/dmitriy/server-spb-my-1-hdd-1tb_1/DEV/APK/thread-fon/

# Задача для сборки релизного APK и копирования в указанную папку
build-send-apk: create-apk-dir $(MAKE) gen-all
	@echo "Сборка релизного APK..."
	$(FLUTTER) build apk --release
	$(MAKE) copy-apk
	@echo "Сборка и копирование APK завершены успешно."

# Задача для сборки релизного AAB, генерации отладочных символов и копирования в указанную папку

build-aab:
	@echo "Генерация всех необходимых файлов..."
	$(MAKE) gen-all
	@echo "Сборка релизного AAB..."
	$(FLUTTER) build appbundle --release
	@echo "Создание целевой директории, если она не существует..."
	mkdir -p /home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/artifact
	@echo "Копирование AAB-файлов с заменой существующих..."
	cp -f build/app/outputs/bundle/release/app-release.aab /home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/artifact/
	@echo "Архивирование отладочных символов..."
	cd build/app/intermediates/merged_native_libs/release/out/lib && zip -r /home/dmitriy/Documents/DEV/MY_GITHUB/thread_fon/artifact/symbols.zip .
	@echo "Сборка и копирование AAB завершены успешно."
	@echo "Файл в /artifact"
	@echo "https://play.google.com/console/u/2/developers/8779815622631445033/app/4972305078485792527/bundle-explorer-selector"
	@echo "После загрузки aab добавь войди в скачанные файлы этого aab и загрузи symbols.zip в Нативные отладочные символы"

########################
# Очистка кеша и получение зависимостей для всего проекта
########################

refresh-all: cache-clean clean get-all

# Обновление всех зависимостей для всего проекта
upgrade-all: upgrade clean get-all

########################
# Очистка кеша pub
########################

cache-clean:
	$(FLUTTER) pub cache clean

# Обновление зависимостей
upgrade:
	$(FLUTTER) pub upgrade

########################
# Исправление проблем с CocoaPods
########################

fix-cocoapods:
	@echo "Переустанавливаю CocoaPods..."
	brew reinstall cocoapods
	@echo "Очистка кеша CocoaPods..."
	pod cache clean --all
	@echo "Запуск pod install..."
	cd ios && pod install
	@echo "Очистка Flutter и получение зависимостей..."
	$(FLUTTER) clean
	$(FLUTTER) pub get
	@echo "Задача fix-cocoapods завершена."

########################
# Инициализация проекта
########################

# Задача инициализации проекта
init:
	fvm use
	git pull --rebase=false
	$(MAKE) get-all
	$(MAKE) gen-all
	$(MAKE) format
	$(MAKE) fix
