/// Статусы экрана
enum EnumStatus {
  init, // Инициализация
  load, // Загрузка данных
  success, // Успешное выполнение
  error, // Ошибка
  transition,
  navigateToNextScreen, // Переход на следующий экран
}
