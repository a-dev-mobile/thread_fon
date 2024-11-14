/// Статусы
enum EnumPageStatus {
  /// Страница в процессе загрузки данных
  initial,

  /// Страница в процессе загрузки данных
  loading,

  /// Данные успешно загружены, страница готова к отображению
  success,

  /// Произошла ошибка при загрузке данных
  error,
}

extension $EnumStatus on EnumPageStatus {
  bool get isLoad => this == EnumPageStatus.loading;
  bool get isError => this == EnumPageStatus.error;
  bool get isSuccess => this == EnumPageStatus.success;
  bool get isInitial => this == EnumPageStatus.initial;
}
