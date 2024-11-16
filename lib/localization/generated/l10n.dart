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

  /// `About App`
  String get about {
    return Intl.message(
      'About App',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Additional information`
  String get additional_info {
    return Intl.message(
      'Additional information',
      name: 'additional_info',
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

  /// `ThreadFon`
  String get app_name {
    return Intl.message(
      'ThreadFon',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
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

  /// `Bolt`
  String get bolt {
    return Intl.message(
      'Bolt',
      name: 'bolt',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
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

  /// `D1_es tolerance`
  String get d1_es_tolerance {
    return Intl.message(
      'D1_es tolerance',
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

  /// `D2_ei tolerance`
  String get d2_ei_tolerance {
    return Intl.message(
      'D2_ei tolerance',
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

  /// `D2_es tolerance`
  String get d2_es_tolerance {
    return Intl.message(
      'D2_es tolerance',
      name: 'd2_es_tolerance',
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

  /// `D_ei tolerance`
  String get d_ei_tolerance {
    return Intl.message(
      'D_ei tolerance',
      name: 'd_ei_tolerance',
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

  /// `D_es tolerance`
  String get d_es_tolerance {
    return Intl.message(
      'D_es tolerance',
      name: 'd_es_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `- Major diameter tolerances`
  String get dialog_about_app_1 {
    return Intl.message(
      '- Major diameter tolerances',
      name: 'dialog_about_app_1',
      desc: '',
      args: [],
    );
  }

  /// `- Pitch diameter tolerances`
  String get dialog_about_app_2 {
    return Intl.message(
      '- Pitch diameter tolerances',
      name: 'dialog_about_app_2',
      desc: '',
      args: [],
    );
  }

  /// `- Minor diameter tolerances`
  String get dialog_about_app_3 {
    return Intl.message(
      '- Minor diameter tolerances',
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

  /// `With this application you can find out the basic parameters of the thread, as well as:`
  String get dialog_title_about_app {
    return Intl.message(
      'With this application you can find out the basic parameters of the thread, as well as:',
      name: 'dialog_title_about_app',
      desc: '',
      args: [],
    );
  }

  /// `Diameter`
  String get diameter {
    return Intl.message(
      'Diameter',
      name: 'diameter',
      desc: '',
      args: [],
    );
  }

  /// `Diameters`
  String get diameters {
    return Intl.message(
      'Diameters',
      name: 'diameters',
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

  /// `Pitch diameter`
  String get diam_middle {
    return Intl.message(
      'Pitch diameter',
      name: 'diam_middle',
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

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
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

  /// `external`
  String get external_thread {
    return Intl.message(
      'external',
      name: 'external_thread',
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

  /// `Oops, something went wrong!\nTry again\n`
  String get generalError {
    return Intl.message(
      'Oops, something went wrong!\nTry again\n',
      name: 'generalError',
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

  /// `h`
  String get h {
    return Intl.message(
      'h',
      name: 'h',
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

  /// `internal`
  String get internal_thread {
    return Intl.message(
      'internal',
      name: 'internal_thread',
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

  /// `Russian`
  String get lang_ru {
    return Intl.message(
      'Russian',
      name: 'lang_ru',
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

  /// `Loading...`
  String get loadingMessage {
    return Intl.message(
      'Loading...',
      name: 'loadingMessage',
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

  /// `Major diameter`
  String get major_diam {
    return Intl.message(
      'Major diameter',
      name: 'major_diam',
      desc: '',
      args: [],
    );
  }

  /// `Mean major diameter`
  String get major_diam_avg {
    return Intl.message(
      'Mean major diameter',
      name: 'major_diam_avg',
      desc: '',
      args: [],
    );
  }

  /// `Max major diameter`
  String get major_diam_max {
    return Intl.message(
      'Max major diameter',
      name: 'major_diam_max',
      desc: '',
      args: [],
    );
  }

  /// `Min major diameter`
  String get major_diam_min {
    return Intl.message(
      'Min major diameter',
      name: 'major_diam_min',
      desc: '',
      args: [],
    );
  }

  /// `Major diameter tolerance`
  String get major_diam_tolerance {
    return Intl.message(
      'Major diameter tolerance',
      name: 'major_diam_tolerance',
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

  /// `mean`
  String get mean {
    return Intl.message(
      'mean',
      name: 'mean',
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

  /// `M`
  String get m_thread_abrv {
    return Intl.message(
      'M',
      name: 'm_thread_abrv',
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

  /// `ISO 965: ISO general purpose metric screw threads`
  String get m_thread_gost {
    return Intl.message(
      'ISO 965: ISO general purpose metric screw threads',
      name: 'm_thread_gost',
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

  /// `min`
  String get min {
    return Intl.message(
      'min',
      name: 'min',
      desc: '',
      args: [],
    );
  }

  /// `Minor diameter`
  String get minor_diam {
    return Intl.message(
      'Minor diameter',
      name: 'minor_diam',
      desc: '',
      args: [],
    );
  }

  /// `Mean minor diameter`
  String get minor_diam_avg {
    return Intl.message(
      'Mean minor diameter',
      name: 'minor_diam_avg',
      desc: '',
      args: [],
    );
  }

  /// `Minor diameter D1`
  String get minor_diam_d1 {
    return Intl.message(
      'Minor diameter D1',
      name: 'minor_diam_d1',
      desc: '',
      args: [],
    );
  }

  /// `Minor diameter D3`
  String get minor_diam_d3 {
    return Intl.message(
      'Minor diameter D3',
      name: 'minor_diam_d3',
      desc: '',
      args: [],
    );
  }

  /// `Max minor diameter`
  String get minor_diam_max {
    return Intl.message(
      'Max minor diameter',
      name: 'minor_diam_max',
      desc: '',
      args: [],
    );
  }

  /// `Min minor diameter`
  String get minor_diam_min {
    return Intl.message(
      'Min minor diameter',
      name: 'minor_diam_min',
      desc: '',
      args: [],
    );
  }

  /// `Minor diameter tolerance`
  String get minor_diam_tolerance {
    return Intl.message(
      'Minor diameter tolerance',
      name: 'minor_diam_tolerance',
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

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
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

  /// `No data to display`
  String get no_svg_data {
    return Intl.message(
      'No data to display',
      name: 'no_svg_data',
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

  /// `Pitch`
  String get pitch {
    return Intl.message(
      'Pitch',
      name: 'pitch',
      desc: '',
      args: [],
    );
  }

  /// `Pitch diameter`
  String get pitch_diam {
    return Intl.message(
      'Pitch diameter',
      name: 'pitch_diam',
      desc: '',
      args: [],
    );
  }

  /// `Mean pitch diameter`
  String get pitch_diam_avg {
    return Intl.message(
      'Mean pitch diameter',
      name: 'pitch_diam_avg',
      desc: '',
      args: [],
    );
  }

  /// `Pitch diameter D2`
  String get pitch_diam_d2 {
    return Intl.message(
      'Pitch diameter D2',
      name: 'pitch_diam_d2',
      desc: '',
      args: [],
    );
  }

  /// `Max pitch diameter`
  String get pitch_diam_max {
    return Intl.message(
      'Max pitch diameter',
      name: 'pitch_diam_max',
      desc: '',
      args: [],
    );
  }

  /// `Min pitch diameter`
  String get pitch_diam_min {
    return Intl.message(
      'Min pitch diameter',
      name: 'pitch_diam_min',
      desc: '',
      args: [],
    );
  }

  /// `Pitch diameter tolerance`
  String get pitch_diam_tolerance {
    return Intl.message(
      'Pitch diameter tolerance',
      name: 'pitch_diam_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `Precision`
  String get precision {
    return Intl.message(
      'Precision',
      name: 'precision',
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

  /// `Restart App`
  String get restartApp {
    return Intl.message(
      'Restart App',
      name: 'restartApp',
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

  /// `Choose diameter`
  String get select_diameter {
    return Intl.message(
      'Choose diameter',
      name: 'select_diameter',
      desc: '',
      args: [],
    );
  }

  /// `Choose pitch`
  String get select_pitch {
    return Intl.message(
      'Choose pitch',
      name: 'select_pitch',
      desc: '',
      args: [],
    );
  }

  /// `Choose tolerance`
  String get select_tolerance {
    return Intl.message(
      'Choose tolerance',
      name: 'select_tolerance',
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

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for using our application`
  String get thank_you {
    return Intl.message(
      'Thank you for using our application',
      name: 'thank_you',
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

  /// `Depth`
  String get thread_depth {
    return Intl.message(
      'Depth',
      name: 'thread_depth',
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

  /// `Thread information`
  String get threads_info {
    return Intl.message(
      'Thread information',
      name: 'threads_info',
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

  /// `Super fine pitch`
  String get thread_pitch_superfine {
    return Intl.message(
      'Super fine pitch',
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

  /// `Thread type`
  String get thread_type {
    return Intl.message(
      'Thread type',
      name: 'thread_type',
      desc: '',
      args: [],
    );
  }

  /// `Tolerance`
  String get tolerance {
    return Intl.message(
      'Tolerance',
      name: 'tolerance',
      desc: '',
      args: [],
    );
  }

  /// `Pitch type`
  String get type_pitch {
    return Intl.message(
      'Pitch type',
      name: 'type_pitch',
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

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
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

  /// `Dark theme`
  String get dark_theme {
    return Intl.message(
      'Dark theme',
      name: 'dark_theme',
      desc: '',
      args: [],
    );
  }

  /// `Choose language`
  String get choose_language {
    return Intl.message(
      'Choose language',
      name: 'choose_language',
      desc: '',
      args: [],
    );
  }

  /// `Choose theme`
  String get choose_theme {
    return Intl.message(
      'Choose theme',
      name: 'choose_theme',
      desc: '',
      args: [],
    );
  }

  /// `Light theme`
  String get light_theme {
    return Intl.message(
      'Light theme',
      name: 'light_theme',
      desc: '',
      args: [],
    );
  }

  /// `Send email`
  String get send_email {
    return Intl.message(
      'Send email',
      name: 'send_email',
      desc: '',
      args: [],
    );
  }

  /// `No email application found.`
  String get email_app_not_found {
    return Intl.message(
      'No email application found.',
      name: 'email_app_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Failed to send email.`
  String get email_sending_failed {
    return Intl.message(
      'Failed to send email.',
      name: 'email_sending_failed',
      desc: '',
      args: [],
    );
  }

  /// `Leave feedback`
  String get leave_feedback {
    return Intl.message(
      'Leave feedback',
      name: 'leave_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Height of the fundamental thread triangle (H)`
  String get heightOfFundamentalTriangle {
    return Intl.message(
      'Height of the fundamental thread triangle (H)',
      name: 'heightOfFundamentalTriangle',
      desc: '',
      args: [],
    );
  }

  /// `Working height of the thread profile (5H/8)`
  String get workingHeightOfProfile {
    return Intl.message(
      'Working height of the thread profile (5H/8)',
      name: 'workingHeightOfProfile',
      desc: '',
      args: [],
    );
  }

  /// `Crest truncation (H/8)`
  String get crestTruncation {
    return Intl.message(
      'Crest truncation (H/8)',
      name: 'crestTruncation',
      desc: '',
      args: [],
    );
  }

  /// `Root truncation (H/4)`
  String get rootTruncation {
    return Intl.message(
      'Root truncation (H/4)',
      name: 'rootTruncation',
      desc: '',
      args: [],
    );
  }

  /// `Total truncation (3H/8)`
  String get totalTruncation {
    return Intl.message(
      'Total truncation (3H/8)',
      name: 'totalTruncation',
      desc: '',
      args: [],
    );
  }

  /// `Half pitch (P/2)`
  String get halfPitch {
    return Intl.message(
      'Half pitch (P/2)',
      name: 'halfPitch',
      desc: '',
      args: [],
    );
  }

  /// `Quarter pitch (P/4)`
  String get quarterPitch {
    return Intl.message(
      'Quarter pitch (P/4)',
      name: 'quarterPitch',
      desc: '',
      args: [],
    );
  }

  /// `Eighth of pitch (P/8)`
  String get eighthPitch {
    return Intl.message(
      'Eighth of pitch (P/8)',
      name: 'eighthPitch',
      desc: '',
      args: [],
    );
  }

  /// `Hole diameter for thread`
  String get threadHoleDiameter {
    return Intl.message(
      'Hole diameter for thread',
      name: 'threadHoleDiameter',
      desc: '',
      args: [],
    );
  }

  /// `d3 - Internal diameter at the bottom of the groove`
  String get d3_label {
    return Intl.message(
      'd3 - Internal diameter at the bottom of the groove',
      name: 'd3_label',
      desc: '',
      args: [],
    );
  }

  /// `Cmin - Minimum truncation of thread crest`
  String get cmin_label {
    return Intl.message(
      'Cmin - Minimum truncation of thread crest',
      name: 'cmin_label',
      desc: '',
      args: [],
    );
  }

  /// `Cmax - Maximum truncation of thread crest`
  String get cmax_label {
    return Intl.message(
      'Cmax - Maximum truncation of thread crest',
      name: 'cmax_label',
      desc: '',
      args: [],
    );
  }

  /// `Rmax - Maximum rounding radius of the thread groove`
  String get rmax_label {
    return Intl.message(
      'Rmax - Maximum rounding radius of the thread groove',
      name: 'rmax_label',
      desc: '',
      args: [],
    );
  }

  /// `Rmin - Minimum rounding radius of the thread groove`
  String get rmin_label {
    return Intl.message(
      'Rmin - Minimum rounding radius of the thread groove',
      name: 'rmin_label',
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
