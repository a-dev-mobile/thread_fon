/// Статусы
enum EnumStatus {
  /// Начальное состояние страницы перед загрузкой данных
  init,

  /// Страница в процессе загрузки данных
  load,

  /// Данные успешно загружены, страница готова к отображению
  success,

  /// Произошла ошибка при загрузке данных
  error,

  prepareNavigating,
  navigating, // Переход на следующий экран
}

extension $EnumStatus on EnumStatus {
  bool get isInit => this == EnumStatus.init;
  bool get isLoad => this == EnumStatus.load;
  bool get isError => this == EnumStatus.error;
  bool get isSuccess => this == EnumStatus.success;
  bool get isNavigating => this == EnumStatus.navigating;
  bool get isPrepareNavigating => this == EnumStatus.prepareNavigating;
}
