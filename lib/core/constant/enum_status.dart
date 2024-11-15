/// Статусы
enum EnumStatus {
  /// Страница в процессе загрузки данных
  initial,

  /// Страница в процессе загрузки данных
  loading,

  /// Данные успешно загружены, страница готова к отображению
  success,

  /// Произошла ошибка при загрузке данных
  error,
}

extension $EnumStatus on EnumStatus {
  bool get isLoad => this == EnumStatus.loading;
  bool get isError => this == EnumStatus.error;
  bool get isSuccess => this == EnumStatus.success;
  bool get isInitial => this == EnumStatus.initial;
}
