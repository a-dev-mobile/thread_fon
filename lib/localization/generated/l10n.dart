// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class GeneratedLocalization {
  GeneratedLocalization();

  static GeneratedLocalization? _current;

  static GeneratedLocalization get current {
    assert(_current != null,
        'No instance of GeneratedLocalization was loaded. Try to initialize the GeneratedLocalization delegate before accessing GeneratedLocalization.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<GeneratedLocalization> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = GeneratedLocalization();
      GeneratedLocalization._current = instance;

      return instance;
    });
  }

  static GeneratedLocalization of(BuildContext context) {
    final instance = GeneratedLocalization.maybeOf(context);
    assert(instance != null,
        'No instance of GeneratedLocalization present in the widget tree. Did you add GeneratedLocalization.delegate in localizationsDelegates?');
    return instance!;
  }

  static GeneratedLocalization? maybeOf(BuildContext context) {
    return Localizations.of<GeneratedLocalization>(
        context, GeneratedLocalization);
  }

  /// `en_US`
  String get localeCode {
    return Intl.message(
      'en_US',
      name: 'localeCode',
      desc: '',
      args: [],
    );
  }

  /// `en`
  String get languageCode {
    return Intl.message(
      'en',
      name: 'languageCode',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get main {
    return Intl.message(
      'Home',
      name: 'main',
      desc: '',
      args: [],
    );
  }

  /// `Сhoose diameter`
  String get select_diameter {
    return Intl.message(
      'Сhoose diameter',
      name: 'select_diameter',
      desc: '',
      args: [],
    );
  }

  /// `Сhoose tolerance`
  String get select_tolerance {
    return Intl.message(
      'Сhoose tolerance',
      name: 'select_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `Сhoose pitch`
  String get select_pitch {
    return Intl.message(
      'Сhoose pitch',
      name: 'select_pitch',
      desc: '',
      args: [],
    );
  }

  /// `major_diam_min`
  String get major_diam_min {
    return Intl.message(
      'major_diam_min',
      name: 'major_diam_min',
      desc: '',
      args: [],
    );
  }

  /// `major_diam_avg`
  String get major_diam_avg {
    return Intl.message(
      'major_diam_avg',
      name: 'major_diam_avg',
      desc: '',
      args: [],
    );
  }

  /// `major_diam_max`
  String get major_diam_max {
    return Intl.message(
      'major_diam_max',
      name: 'major_diam_max',
      desc: '',
      args: [],
    );
  }

  /// `pitch_diam_d2`
  String get pitch_diam_d2 {
    return Intl.message(
      'pitch_diam_d2',
      name: 'pitch_diam_d2',
      desc: '',
      args: [],
    );
  }

  /// `pitch_diam_min`
  String get pitch_diam_min {
    return Intl.message(
      'pitch_diam_min',
      name: 'pitch_diam_min',
      desc: '',
      args: [],
    );
  }

  /// `pitch_diam_avg`
  String get pitch_diam_avg {
    return Intl.message(
      'pitch_diam_avg',
      name: 'pitch_diam_avg',
      desc: '',
      args: [],
    );
  }

  /// `pitch_diam_max`
  String get pitch_diam_max {
    return Intl.message(
      'pitch_diam_max',
      name: 'pitch_diam_max',
      desc: '',
      args: [],
    );
  }

  /// `minor_diam_min`
  String get minor_diam_min {
    return Intl.message(
      'minor_diam_min',
      name: 'minor_diam_min',
      desc: '',
      args: [],
    );
  }

  /// `minor_diam_avg`
  String get minor_diam_avg {
    return Intl.message(
      'minor_diam_avg',
      name: 'minor_diam_avg',
      desc: '',
      args: [],
    );
  }

  /// `minor_diam_max`
  String get minor_diam_max {
    return Intl.message(
      'minor_diam_max',
      name: 'minor_diam_max',
      desc: '',
      args: [],
    );
  }

  /// `minor_diam_d1`
  String get minor_diam_d1 {
    return Intl.message(
      'minor_diam_d1',
      name: 'minor_diam_d1',
      desc: '',
      args: [],
    );
  }

  /// `minor_diam_d3`
  String get minor_diam_d3 {
    return Intl.message(
      'minor_diam_d3',
      name: 'minor_diam_d3',
      desc: '',
      args: [],
    );
  }

  /// `h`
  String get h {
    return Intl.message(
      'h',
      name: 'h',
      desc: '',
      args: [],
    );
  }

  /// `Информация о резьбе`
  String get threads_info {
    return Intl.message(
      'Информация о резьбе',
      name: 'threads_info',
      desc: '',
      args: [],
    );
  }

  /// `Диаметр`
  String get diameter {
    return Intl.message(
      'Диаметр',
      name: 'diameter',
      desc: '',
      args: [],
    );
  }

  /// `Шаг`
  String get pitch {
    return Intl.message(
      'Шаг',
      name: 'pitch',
      desc: '',
      args: [],
    );
  }

  /// `Допуск`
  String get tolerance {
    return Intl.message(
      'Допуск',
      name: 'tolerance',
      desc: '',
      args: [],
    );
  }

  /// `Тип шага`
  String get type_pitch {
    return Intl.message(
      'Тип шага',
      name: 'type_pitch',
      desc: '',
      args: [],
    );
  }

  /// `Глубина`
  String get thread_depth {
    return Intl.message(
      'Глубина',
      name: 'thread_depth',
      desc: '',
      args: [],
    );
  }

  /// `Диаметры`
  String get diameters {
    return Intl.message(
      'Диаметры',
      name: 'diameters',
      desc: '',
      args: [],
    );
  }

  /// `Основной диаметр`
  String get major_diam {
    return Intl.message(
      'Основной диаметр',
      name: 'major_diam',
      desc: '',
      args: [],
    );
  }

  /// `Допуск основного диаметра`
  String get major_diam_tolerance {
    return Intl.message(
      'Допуск основного диаметра',
      name: 'major_diam_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `Диаметр пича`
  String get pitch_diam {
    return Intl.message(
      'Диаметр пича',
      name: 'pitch_diam',
      desc: '',
      args: [],
    );
  }

  /// `Допуск диаметра пича`
  String get pitch_diam_tolerance {
    return Intl.message(
      'Допуск диаметра пича',
      name: 'pitch_diam_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `Минорный диаметр`
  String get minor_diam {
    return Intl.message(
      'Минорный диаметр',
      name: 'minor_diam',
      desc: '',
      args: [],
    );
  }

  /// `Допуск минорного диаметра`
  String get minor_diam_tolerance {
    return Intl.message(
      'Допуск минорного диаметра',
      name: 'minor_diam_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `Дополнительная информация`
  String get additional_info {
    return Intl.message(
      'Дополнительная информация',
      name: 'additional_info',
      desc: '',
      args: [],
    );
  }

  /// `D_es`
  String get d_es {
    return Intl.message(
      'D_es',
      name: 'd_es',
      desc: '',
      args: [],
    );
  }

  /// `Допуск D_es`
  String get d_es_tolerance {
    return Intl.message(
      'Допуск D_es',
      name: 'd_es_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `D_ei`
  String get d_ei {
    return Intl.message(
      'D_ei',
      name: 'd_ei',
      desc: '',
      args: [],
    );
  }

  /// `Допуск D_ei`
  String get d_ei_tolerance {
    return Intl.message(
      'Допуск D_ei',
      name: 'd_ei_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `D1_es`
  String get d1_es {
    return Intl.message(
      'D1_es',
      name: 'd1_es',
      desc: '',
      args: [],
    );
  }

  /// `Допуск D1_es`
  String get d1_es_tolerance {
    return Intl.message(
      'Допуск D1_es',
      name: 'd1_es_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `D2_ei`
  String get d2_ei {
    return Intl.message(
      'D2_ei',
      name: 'd2_ei',
      desc: '',
      args: [],
    );
  }

  /// `Допуск D2_ei`
  String get d2_ei_tolerance {
    return Intl.message(
      'Допуск D2_ei',
      name: 'd2_ei_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `D2_es`
  String get d2_es {
    return Intl.message(
      'D2_es',
      name: 'd2_es',
      desc: '',
      args: [],
    );
  }

  /// `Допуск D2_es`
  String get d2_es_tolerance {
    return Intl.message(
      'Допуск D2_es',
      name: 'd2_es_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `Нет данных для отображения`
  String get no_svg_data {
    return Intl.message(
      'Нет данных для отображения',
      name: 'no_svg_data',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Restart App`
  String get restartApp {
    return Intl.message(
      'Restart App',
      name: 'restartApp',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message(
      'Settings',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Application language`
  String get app_lang {
    return Intl.message(
      'Application language',
      name: 'app_lang',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get lang_ru {
    return Intl.message(
      'Russian',
      name: 'lang_ru',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get lang_en {
    return Intl.message(
      'English',
      name: 'lang_en',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get dark_theme {
    return Intl.message(
      'Dark theme',
      name: 'dark_theme',
      desc: '',
      args: [],
    );
  }

  /// `Oops, something went wrong!\nTry again\n`
  String get generalError {
    return Intl.message(
      'Oops, something went wrong!\nTry again\n',
      name: 'generalError',
      desc: '',
      args: [],
    );
  }

  /// `Launch`
  String get launch {
    return Intl.message(
      'Launch',
      name: 'launch',
      desc: '',
      args: [],
    );
  }

  /// `ThreadFon`
  String get app_name {
    return Intl.message(
      'ThreadFon',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Metric thread`
  String get m_thread {
    return Intl.message(
      'Metric thread',
      name: 'm_thread',
      desc: '',
      args: [],
    );
  }

  /// `M - Metric cylindrical internal thread`
  String get m_thread_female_description {
    return Intl.message(
      'M - Metric cylindrical internal thread',
      name: 'm_thread_female_description',
      desc: '',
      args: [],
    );
  }

  /// `M - Metric cylindrical external thread`
  String get m_thread_male_description {
    return Intl.message(
      'M - Metric cylindrical external thread',
      name: 'm_thread_male_description',
      desc: '',
      args: [],
    );
  }

  /// `ISO 965: ISO general purpose metric screw threads`
  String get m_thread_gost {
    return Intl.message(
      'ISO 965: ISO general purpose metric screw threads',
      name: 'm_thread_gost',
      desc: '',
      args: [],
    );
  }

  /// `M`
  String get m_thread_abrv {
    return Intl.message(
      'M',
      name: 'm_thread_abrv',
      desc: '',
      args: [],
    );
  }

  /// `Thread type`
  String get thread_type {
    return Intl.message(
      'Thread type',
      name: 'thread_type',
      desc: '',
      args: [],
    );
  }

  /// `Major diameter`
  String get diam_major {
    return Intl.message(
      'Major diameter',
      name: 'diam_major',
      desc: '',
      args: [],
    );
  }

  /// `Minor diameter`
  String get diam_minor {
    return Intl.message(
      'Minor diameter',
      name: 'diam_minor',
      desc: '',
      args: [],
    );
  }

  /// `Pitch diameter`
  String get diam_middle {
    return Intl.message(
      'Pitch diameter',
      name: 'diam_middle',
      desc: '',
      args: [],
    );
  }

  /// `Diameter`
  String get thread_diam {
    return Intl.message(
      'Diameter',
      name: 'thread_diam',
      desc: '',
      args: [],
    );
  }

  /// `Diameter (nominal)`
  String get thread_diam_nom {
    return Intl.message(
      'Diameter (nominal)',
      name: 'thread_diam_nom',
      desc: '',
      args: [],
    );
  }

  /// `Pitch`
  String get thread_pitch {
    return Intl.message(
      'Pitch',
      name: 'thread_pitch',
      desc: '',
      args: [],
    );
  }

  /// `Tolerance class`
  String get thread_class_tolerance {
    return Intl.message(
      'Tolerance class',
      name: 'thread_class_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `Coarse pitch`
  String get thread_pitch_coarse {
    return Intl.message(
      'Coarse pitch',
      name: 'thread_pitch_coarse',
      desc: '',
      args: [],
    );
  }

  /// `Fine pitch`
  String get thread_pitch_fine {
    return Intl.message(
      'Fine pitch',
      name: 'thread_pitch_fine',
      desc: '',
      args: [],
    );
  }

  /// `Extra fine pitch`
  String get thread_pitch_superfine {
    return Intl.message(
      'Extra fine pitch',
      name: 'thread_pitch_superfine',
      desc: '',
      args: [],
    );
  }

  /// `Tolerance`
  String get thread_tolerance {
    return Intl.message(
      'Tolerance',
      name: 'thread_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `internal`
  String get internal_thread {
    return Intl.message(
      'internal',
      name: 'internal_thread',
      desc: '',
      args: [],
    );
  }

  /// `external`
  String get external_thread {
    return Intl.message(
      'external',
      name: 'external_thread',
      desc: '',
      args: [],
    );
  }

  /// `Designation`
  String get thread_designation {
    return Intl.message(
      'Designation',
      name: 'thread_designation',
      desc: '',
      args: [],
    );
  }

  /// `G`
  String get g_thread_abrv {
    return Intl.message(
      'G',
      name: 'g_thread_abrv',
      desc: '',
      args: [],
    );
  }

  /// `Nuts`
  String get nuts {
    return Intl.message(
      'Nuts',
      name: 'nuts',
      desc: '',
      args: [],
    );
  }

  /// `Bolt`
  String get bolt {
    return Intl.message(
      'Bolt',
      name: 'bolt',
      desc: '',
      args: [],
    );
  }

  /// `mean`
  String get mean {
    return Intl.message(
      'mean',
      name: 'mean',
      desc: '',
      args: [],
    );
  }

  /// `Load...`
  String get loadingMessage {
    return Intl.message(
      'Load...',
      name: 'loadingMessage',
      desc: '',
      args: [],
    );
  }

  /// `Thank You for choosing our application`
  String get thank_you {
    return Intl.message(
      'Thank You for choosing our application',
      name: 'thank_you',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `With this application you will be able to find out the basic parameters of the thread as well:`
  String get dialog_title_about_app {
    return Intl.message(
      'With this application you will be able to find out the basic parameters of the thread as well:',
      name: 'dialog_title_about_app',
      desc: '',
      args: [],
    );
  }

  /// `-Major diameter tolerances`
  String get dialog_about_app_1 {
    return Intl.message(
      '-Major diameter tolerances',
      name: 'dialog_about_app_1',
      desc: '',
      args: [],
    );
  }

  /// `-Pitch diameter tolerances`
  String get dialog_about_app_2 {
    return Intl.message(
      '-Pitch diameter tolerances',
      name: 'dialog_about_app_2',
      desc: '',
      args: [],
    );
  }

  /// `-Minor diameter tolerances`
  String get dialog_about_app_3 {
    return Intl.message(
      '-Minor diameter tolerances',
      name: 'dialog_about_app_3',
      desc: '',
      args: [],
    );
  }

  /// `---`
  String get dialog_about_app_4 {
    return Intl.message(
      '---',
      name: 'dialog_about_app_4',
      desc: '',
      args: [],
    );
  }

  /// `Always check your result!`
  String get dialog_about_app_5 {
    return Intl.message(
      'Always check your result!',
      name: 'dialog_about_app_5',
      desc: '',
      args: [],
    );
  }

  /// `About App`
  String get about {
    return Intl.message(
      'About App',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Rate app`
  String get rate_app {
    return Intl.message(
      'Rate app',
      name: 'rate_app',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message(
      'Feedback',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Exit app`
  String get exit_app {
    return Intl.message(
      'Exit app',
      name: 'exit_app',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to quit the app?`
  String get exit_app_warning {
    return Intl.message(
      'Are you sure you want to quit the app?',
      name: 'exit_app_warning',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Units`
  String get units {
    return Intl.message(
      'Units',
      name: 'units',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `mm`
  String get mm {
    return Intl.message(
      'mm',
      name: 'mm',
      desc: '',
      args: [],
    );
  }

  /// `inch`
  String get inch {
    return Intl.message(
      'inch',
      name: 'inch',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get no_data {
    return Intl.message(
      'No data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `avg`
  String get avg {
    return Intl.message(
      'avg',
      name: 'avg',
      desc: '',
      args: [],
    );
  }

  /// `max`
  String get max {
    return Intl.message(
      'max',
      name: 'max',
      desc: '',
      args: [],
    );
  }

  /// `min`
  String get min {
    return Intl.message(
      'min',
      name: 'min',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<GeneratedLocalization> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<GeneratedLocalization> load(Locale locale) =>
      GeneratedLocalization.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
