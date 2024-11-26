# Переменные для использования fvm flutter и fvm dart
FLUTTER = fvm flutter
DART = fvm dart

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
# $(FLUTTER) gen-l10n --arb-dir lib/src/common/localization --output-dir lib/src/common/localization/generated --template-arb-file intl_en.arb

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

# Задача для сборки релизного APK и копирования в указанную папку
build-android:
	@echo "Генерация всех необходимых файлов..."
	$(MAKE) gen-all
	@echo "Сборка релизного APK..."
	$(FLUTTER) build apk --release
	@echo "Создание целевой директории, если она не существует..."
	mkdir -p /home/dmitriy/server-spb-my-1-hdd-1tb_1/DEV/APK/thread-fon/
	@echo "Копирование APK-файлов с заменой существующих..."
	cp -f build/app/outputs/flutter-apk/app-*.apk /home/dmitriy/server-spb-my-1-hdd-1tb_1/DEV/APK/thread-fon/
	@echo "Сборка и копирование APK завершены успешно."

# Очистка кеша и получение зависимостей для всего проекта
refresh-all: cache-clean clean get-all

# Обновление всех зависимостей для всего проекта
upgrade-all: upgrade clean get-all

# Очистка кеша pub
cache-clean:
	$(FLUTTER) pub cache clean

# Обновление зависимостей
upgrade:
	$(FLUTTER) pub upgrade



# Задача для исправления проблем с CocoaPods

fix-cocoapods:
	@echo "Переустанавливаю CocoaPods..."
	brew reinstall cocoapods
	@echo "Очистка кеша CocoaPods..."
	pod cache clean --all
	@echo "Запуск pod install..."
	cd ios && pod install
	@echo "Очистка Flutter и получение зависимостей..."
	flutter clean
	flutter pub get
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
