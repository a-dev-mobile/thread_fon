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
    assert(
      _current != null,
      'No instance of GeneratedLocalization was loaded. Try to initialize the GeneratedLocalization delegate before accessing GeneratedLocalization.current.',
    );
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
    assert(
      instance != null,
      'No instance of GeneratedLocalization present in the widget tree. Did you add GeneratedLocalization.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static GeneratedLocalization? maybeOf(BuildContext context) {
    return Localizations.of<GeneratedLocalization>(
      context,
      GeneratedLocalization,
    );
  }

  /// `en_US`
  String get localeCode {
    return Intl.message('en_US', name: 'localeCode', desc: '', args: []);
  }

  /// `en`
  String get languageCode {
    return Intl.message('en', name: 'languageCode', desc: '', args: []);
  }

  /// `English`
  String get language {
    return Intl.message('English', name: 'language', desc: '', args: []);
  }

  /// `About the App`
  String get about {
    return Intl.message('About the App', name: 'about', desc: '', args: []);
  }

  /// `Additional Information`
  String get additional_info {
    return Intl.message(
      'Additional Information',
      name: 'additional_info',
      desc: '',
      args: [],
    );
  }

  /// `Application Language`
  String get app_lang {
    return Intl.message(
      'Application Language',
      name: 'app_lang',
      desc: '',
      args: [],
    );
  }

  /// `ThreadFon`
  String get app_name {
    return Intl.message('ThreadFon', name: 'app_name', desc: '', args: []);
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `avg`
  String get avg {
    return Intl.message('avg', name: 'avg', desc: '', args: []);
  }

  /// `Bolt`
  String get bolt {
    return Intl.message('Bolt', name: 'bolt', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `D1_es`
  String get d1_es {
    return Intl.message('D1_es', name: 'd1_es', desc: '', args: []);
  }

  /// `D1_es Tolerance`
  String get d1_es_tolerance {
    return Intl.message(
      'D1_es Tolerance',
      name: 'd1_es_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `D2_ei`
  String get d2_ei {
    return Intl.message('D2_ei', name: 'd2_ei', desc: '', args: []);
  }

  /// `D2_ei Tolerance`
  String get d2_ei_tolerance {
    return Intl.message(
      'D2_ei Tolerance',
      name: 'd2_ei_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `D2_es`
  String get d2_es {
    return Intl.message('D2_es', name: 'd2_es', desc: '', args: []);
  }

  /// `D2_es Tolerance`
  String get d2_es_tolerance {
    return Intl.message(
      'D2_es Tolerance',
      name: 'd2_es_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `D_ei`
  String get d_ei {
    return Intl.message('D_ei', name: 'd_ei', desc: '', args: []);
  }

  /// `D_ei Tolerance`
  String get d_ei_tolerance {
    return Intl.message(
      'D_ei Tolerance',
      name: 'd_ei_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `D_es`
  String get d_es {
    return Intl.message('D_es', name: 'd_es', desc: '', args: []);
  }

  /// `D_es Tolerance`
  String get d_es_tolerance {
    return Intl.message(
      'D_es Tolerance',
      name: 'd_es_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `- Tolerances of Major Diameter`
  String get dialog_about_app_1 {
    return Intl.message(
      '- Tolerances of Major Diameter',
      name: 'dialog_about_app_1',
      desc: '',
      args: [],
    );
  }

  /// `- Tolerances of Pitch Diameter`
  String get dialog_about_app_2 {
    return Intl.message(
      '- Tolerances of Pitch Diameter',
      name: 'dialog_about_app_2',
      desc: '',
      args: [],
    );
  }

  /// `- Tolerances of Minor Diameter`
  String get dialog_about_app_3 {
    return Intl.message(
      '- Tolerances of Minor Diameter',
      name: 'dialog_about_app_3',
      desc: '',
      args: [],
    );
  }

  /// `---`
  String get dialog_about_app_4 {
    return Intl.message('---', name: 'dialog_about_app_4', desc: '', args: []);
  }

  /// `Always verify your results!`
  String get dialog_about_app_5 {
    return Intl.message(
      'Always verify your results!',
      name: 'dialog_about_app_5',
      desc: '',
      args: [],
    );
  }

  /// `With this application, you can determine the basic thread parameters, as well as:`
  String get dialog_title_about_app {
    return Intl.message(
      'With this application, you can determine the basic thread parameters, as well as:',
      name: 'dialog_title_about_app',
      desc: '',
      args: [],
    );
  }

  /// `Diameter`
  String get diameter {
    return Intl.message('Diameter', name: 'diameter', desc: '', args: []);
  }

  /// `Diameters`
  String get diameters {
    return Intl.message('Diameters', name: 'diameters', desc: '', args: []);
  }

  /// `Major Diameter`
  String get diam_major {
    return Intl.message(
      'Major Diameter',
      name: 'diam_major',
      desc: '',
      args: [],
    );
  }

  /// `Pitch Diameter`
  String get diam_middle {
    return Intl.message(
      'Pitch Diameter',
      name: 'diam_middle',
      desc: '',
      args: [],
    );
  }

  /// `Minor Diameter`
  String get diam_minor {
    return Intl.message(
      'Minor Diameter',
      name: 'diam_minor',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Exit App`
  String get exit_app {
    return Intl.message('Exit App', name: 'exit_app', desc: '', args: []);
  }

  /// `Are you sure you want to exit the app?`
  String get exit_app_warning {
    return Intl.message(
      'Are you sure you want to exit the app?',
      name: 'exit_app_warning',
      desc: '',
      args: [],
    );
  }

  /// `External Thread`
  String get external_thread {
    return Intl.message(
      'External Thread',
      name: 'external_thread',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message('Feedback', name: 'feedback', desc: '', args: []);
  }

  /// `Oops, something went wrong!\nPlease try again.`
  String get generalError {
    return Intl.message(
      'Oops, something went wrong!\nPlease try again.',
      name: 'generalError',
      desc: '',
      args: [],
    );
  }

  /// `G`
  String get g_thread_abrv {
    return Intl.message('G', name: 'g_thread_abrv', desc: '', args: []);
  }

  /// `h`
  String get h {
    return Intl.message('h', name: 'h', desc: '', args: []);
  }

  /// `inch`
  String get inch {
    return Intl.message('inch', name: 'inch', desc: '', args: []);
  }

  /// `Internal Thread`
  String get internal_thread {
    return Intl.message(
      'Internal Thread',
      name: 'internal_thread',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get lang_en {
    return Intl.message('English', name: 'lang_en', desc: '', args: []);
  }

  /// `Russian`
  String get lang_ru {
    return Intl.message('Russian', name: 'lang_ru', desc: '', args: []);
  }

  /// `Launch`
  String get launch {
    return Intl.message('Launch', name: 'launch', desc: '', args: []);
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
    return Intl.message('Home', name: 'main', desc: '', args: []);
  }

  /// `Mean Major Diameter`
  String get major_diam_avg {
    return Intl.message(
      'Mean Major Diameter',
      name: 'major_diam_avg',
      desc: '',
      args: [],
    );
  }

  /// `Max Major Diameter`
  String get major_diam_max {
    return Intl.message(
      'Max Major Diameter',
      name: 'major_diam_max',
      desc: '',
      args: [],
    );
  }

  /// `Min Major Diameter`
  String get major_diam_min {
    return Intl.message(
      'Min Major Diameter',
      name: 'major_diam_min',
      desc: '',
      args: [],
    );
  }

  /// `Major Diameter Tolerance`
  String get major_diam_tolerance {
    return Intl.message(
      'Major Diameter Tolerance',
      name: 'major_diam_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `max`
  String get max {
    return Intl.message('max', name: 'max', desc: '', args: []);
  }

  /// `mean`
  String get mean {
    return Intl.message('mean', name: 'mean', desc: '', args: []);
  }

  /// `Choose Thread`
  String get choose_thread {
    return Intl.message(
      'Choose Thread',
      name: 'choose_thread',
      desc: '',
      args: [],
    );
  }

  /// `Metric Screw Threads (General Purpose)`
  String get metric_thread {
    return Intl.message(
      'Metric Screw Threads (General Purpose)',
      name: 'metric_thread',
      desc: '',
      args: [],
    );
  }

  /// `ISO 965`
  String get metric_thread_gost {
    return Intl.message(
      'ISO 965',
      name: 'metric_thread_gost',
      desc: '',
      args: [],
    );
  }

  /// `Unified Inch Screw Threads`
  String get imperial_thread {
    return Intl.message(
      'Unified Inch Screw Threads',
      name: 'imperial_thread',
      desc: '',
      args: [],
    );
  }

  /// `ASME/ANSI B1.1`
  String get imperial_thread_gost {
    return Intl.message(
      'ASME/ANSI B1.1',
      name: 'imperial_thread_gost',
      desc: '',
      args: [],
    );
  }

  /// `Trapezoidal Thread`
  String get trapezoidal_thread {
    return Intl.message(
      'Trapezoidal Thread',
      name: 'trapezoidal_thread',
      desc: '',
      args: [],
    );
  }

  /// `ISO 2901, 2903, 2904`
  String get trapezoidal_thread_gost {
    return Intl.message(
      'ISO 2901, 2903, 2904',
      name: 'trapezoidal_thread_gost',
      desc: '',
      args: [],
    );
  }

  /// `Pipe Threads (Cylindrical)`
  String get pipe_thread {
    return Intl.message(
      'Pipe Threads (Cylindrical)',
      name: 'pipe_thread',
      desc: '',
      args: [],
    );
  }

  /// `ISO 228, ANSI/ASME B1.20.1`
  String get pipe_thread_gost {
    return Intl.message(
      'ISO 228, ANSI/ASME B1.20.1',
      name: 'pipe_thread_gost',
      desc: '',
      args: [],
    );
  }

  /// `M`
  String get m_thread_abrv {
    return Intl.message('M', name: 'm_thread_abrv', desc: '', args: []);
  }

  /// `M - Metric Internal Cylindrical Thread`
  String get m_thread_female_description {
    return Intl.message(
      'M - Metric Internal Cylindrical Thread',
      name: 'm_thread_female_description',
      desc: '',
      args: [],
    );
  }

  /// `ISO 965: ISO General Purpose Metric Screw Threads`
  String get m_thread_gost {
    return Intl.message(
      'ISO 965: ISO General Purpose Metric Screw Threads',
      name: 'm_thread_gost',
      desc: '',
      args: [],
    );
  }

  /// `M - Metric External Cylindrical Thread`
  String get m_thread_male_description {
    return Intl.message(
      'M - Metric External Cylindrical Thread',
      name: 'm_thread_male_description',
      desc: '',
      args: [],
    );
  }

  /// `min`
  String get min {
    return Intl.message('min', name: 'min', desc: '', args: []);
  }

  /// `Select Diameter and Pitch`
  String get select_diameter_and_pitch {
    return Intl.message(
      'Select Diameter and Pitch',
      name: 'select_diameter_and_pitch',
      desc: '',
      args: [],
    );
  }

  /// `Mean Minor Diameter`
  String get minor_diam_avg {
    return Intl.message(
      'Mean Minor Diameter',
      name: 'minor_diam_avg',
      desc: '',
      args: [],
    );
  }

  /// `Minor Diameter D1`
  String get minor_diam_d1 {
    return Intl.message(
      'Minor Diameter D1',
      name: 'minor_diam_d1',
      desc: '',
      args: [],
    );
  }

  /// `Minor Diameter D3`
  String get minor_diam_d3 {
    return Intl.message(
      'Minor Diameter D3',
      name: 'minor_diam_d3',
      desc: '',
      args: [],
    );
  }

  /// `Max Minor Diameter`
  String get minor_diam_max {
    return Intl.message(
      'Max Minor Diameter',
      name: 'minor_diam_max',
      desc: '',
      args: [],
    );
  }

  /// `Min Minor Diameter`
  String get minor_diam_min {
    return Intl.message(
      'Min Minor Diameter',
      name: 'minor_diam_min',
      desc: '',
      args: [],
    );
  }

  /// `Minor Diameter Tolerance`
  String get minor_diam_tolerance {
    return Intl.message(
      'Minor Diameter Tolerance',
      name: 'minor_diam_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `mm`
  String get mm {
    return Intl.message('mm', name: 'mm', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `No Data`
  String get no_data {
    return Intl.message('No Data', name: 'no_data', desc: '', args: []);
  }

  /// `No Data to Display`
  String get no_svg_data {
    return Intl.message(
      'No Data to Display',
      name: 'no_svg_data',
      desc: '',
      args: [],
    );
  }

  /// `Nuts`
  String get nuts {
    return Intl.message('Nuts', name: 'nuts', desc: '', args: []);
  }

  /// `Pitch`
  String get pitch {
    return Intl.message('Pitch', name: 'pitch', desc: '', args: []);
  }

  /// `Pitch Diameter`
  String get pitch_diam {
    return Intl.message(
      'Pitch Diameter',
      name: 'pitch_diam',
      desc: '',
      args: [],
    );
  }

  /// `Mean Pitch Diameter`
  String get pitch_diam_avg {
    return Intl.message(
      'Mean Pitch Diameter',
      name: 'pitch_diam_avg',
      desc: '',
      args: [],
    );
  }

  /// `Pitch Diameter D2`
  String get pitch_diam_d2 {
    return Intl.message(
      'Pitch Diameter D2',
      name: 'pitch_diam_d2',
      desc: '',
      args: [],
    );
  }

  /// `Max Pitch Diameter`
  String get pitch_diam_max {
    return Intl.message(
      'Max Pitch Diameter',
      name: 'pitch_diam_max',
      desc: '',
      args: [],
    );
  }

  /// `Min Pitch Diameter`
  String get pitch_diam_min {
    return Intl.message(
      'Min Pitch Diameter',
      name: 'pitch_diam_min',
      desc: '',
      args: [],
    );
  }

  /// `Pitch Diameter Tolerance`
  String get pitch_diam_tolerance {
    return Intl.message(
      'Pitch Diameter Tolerance',
      name: 'pitch_diam_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `Precision`
  String get precision {
    return Intl.message('Precision', name: 'precision', desc: '', args: []);
  }

  /// `Rate the App`
  String get rate_app {
    return Intl.message('Rate the App', name: 'rate_app', desc: '', args: []);
  }

  /// `Restart App`
  String get restartApp {
    return Intl.message('Restart App', name: 'restartApp', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Select Diameter`
  String get select_diameter {
    return Intl.message(
      'Select Diameter',
      name: 'select_diameter',
      desc: '',
      args: [],
    );
  }

  /// `Select Pitch`
  String get select_pitch {
    return Intl.message(
      'Select Pitch',
      name: 'select_pitch',
      desc: '',
      args: [],
    );
  }

  /// `Select Tolerance`
  String get select_tolerance {
    return Intl.message(
      'Select Tolerance',
      name: 'select_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `Select Class`
  String get select_class {
    return Intl.message(
      'Select Class',
      name: 'select_class',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message('Setting', name: 'setting', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
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

  /// `Tolerance Class`
  String get thread_class_tolerance {
    return Intl.message(
      'Tolerance Class',
      name: 'thread_class_tolerance',
      desc: '',
      args: [],
    );
  }

  /// `Thread Depth`
  String get thread_depth {
    return Intl.message(
      'Thread Depth',
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
    return Intl.message('Diameter', name: 'thread_diam', desc: '', args: []);
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
    return Intl.message('Pitch', name: 'thread_pitch', desc: '', args: []);
  }

  /// `Thread Information`
  String get threads_info {
    return Intl.message(
      'Thread Information',
      name: 'threads_info',
      desc: '',
      args: [],
    );
  }

  /// `Coarse Pitch`
  String get thread_pitch_coarse {
    return Intl.message(
      'Coarse Pitch',
      name: 'thread_pitch_coarse',
      desc: '',
      args: [],
    );
  }

  /// `Fine Pitch`
  String get thread_pitch_fine {
    return Intl.message(
      'Fine Pitch',
      name: 'thread_pitch_fine',
      desc: '',
      args: [],
    );
  }

  /// `Super Fine Pitch`
  String get thread_pitch_superfine {
    return Intl.message(
      'Super Fine Pitch',
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

  /// `Thread Type`
  String get thread_type {
    return Intl.message('Thread Type', name: 'thread_type', desc: '', args: []);
  }

  /// `Tolerance`
  String get tolerance {
    return Intl.message('Tolerance', name: 'tolerance', desc: '', args: []);
  }

  /// `Pitch Type`
  String get type_pitch {
    return Intl.message('Pitch Type', name: 'type_pitch', desc: '', args: []);
  }

  /// `Units`
  String get units {
    return Intl.message('Units', name: 'units', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `Choose Language`
  String get choose_language {
    return Intl.message(
      'Choose Language',
      name: 'choose_language',
      desc: '',
      args: [],
    );
  }

  /// `Choose Theme`
  String get choose_theme {
    return Intl.message(
      'Choose Theme',
      name: 'choose_theme',
      desc: '',
      args: [],
    );
  }

  /// `Light Theme`
  String get light_theme {
    return Intl.message('Light Theme', name: 'light_theme', desc: '', args: []);
  }

  /// `Dark Theme`
  String get dark_theme {
    return Intl.message('Dark Theme', name: 'dark_theme', desc: '', args: []);
  }

  /// `Send Email`
  String get send_email {
    return Intl.message('Send Email', name: 'send_email', desc: '', args: []);
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

  /// `Failed to send the email.`
  String get email_sending_failed {
    return Intl.message(
      'Failed to send the email.',
      name: 'email_sending_failed',
      desc: '',
      args: [],
    );
  }

  /// `Leave Feedback`
  String get leave_feedback {
    return Intl.message(
      'Leave Feedback',
      name: 'leave_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Suggest Improvement`
  String get suggest_improvement {
    return Intl.message(
      'Suggest Improvement',
      name: 'suggest_improvement',
      desc: '',
      args: [],
    );
  }

  /// `Height of the Fundamental Thread Triangle (H)`
  String get heightOfFundamentalTriangle {
    return Intl.message(
      'Height of the Fundamental Thread Triangle (H)',
      name: 'heightOfFundamentalTriangle',
      desc: '',
      args: [],
    );
  }

  /// `Working Height of the Thread Profile (5H/8)`
  String get workingHeightOfProfile {
    return Intl.message(
      'Working Height of the Thread Profile (5H/8)',
      name: 'workingHeightOfProfile',
      desc: '',
      args: [],
    );
  }

  /// `Crest Truncation (H/8)`
  String get crestTruncation {
    return Intl.message(
      'Crest Truncation (H/8)',
      name: 'crestTruncation',
      desc: '',
      args: [],
    );
  }

  /// `Root Truncation (H/4)`
  String get rootTruncation {
    return Intl.message(
      'Root Truncation (H/4)',
      name: 'rootTruncation',
      desc: '',
      args: [],
    );
  }

  /// `Total Truncation (3H/8)`
  String get totalTruncation {
    return Intl.message(
      'Total Truncation (3H/8)',
      name: 'totalTruncation',
      desc: '',
      args: [],
    );
  }

  /// `Half Pitch (P/2)`
  String get halfPitch {
    return Intl.message(
      'Half Pitch (P/2)',
      name: 'halfPitch',
      desc: '',
      args: [],
    );
  }

  /// `Quarter Pitch (P/4)`
  String get quarterPitch {
    return Intl.message(
      'Quarter Pitch (P/4)',
      name: 'quarterPitch',
      desc: '',
      args: [],
    );
  }

  /// `Eighth Pitch (P/8)`
  String get eighthPitch {
    return Intl.message(
      'Eighth Pitch (P/8)',
      name: 'eighthPitch',
      desc: '',
      args: [],
    );
  }

  /// `Thread Hole Diameter`
  String get threadHoleDiameter {
    return Intl.message(
      'Thread Hole Diameter',
      name: 'threadHoleDiameter',
      desc: '',
      args: [],
    );
  }

  /// `d3 - Internal diameter at the root of the groove`
  String get d3_label {
    return Intl.message(
      'd3 - Internal diameter at the root of the groove',
      name: 'd3_label',
      desc: '',
      args: [],
    );
  }

  /// `Cmin - Minimum Crest Truncation`
  String get cmin_label {
    return Intl.message(
      'Cmin - Minimum Crest Truncation',
      name: 'cmin_label',
      desc: '',
      args: [],
    );
  }

  /// `Cmax - Maximum Crest Truncation`
  String get cmax_label {
    return Intl.message(
      'Cmax - Maximum Crest Truncation',
      name: 'cmax_label',
      desc: '',
      args: [],
    );
  }

  /// `Rmax - Maximum Root Radius`
  String get rmax_label {
    return Intl.message(
      'Rmax - Maximum Root Radius',
      name: 'rmax_label',
      desc: '',
      args: [],
    );
  }

  /// `Rmin - Minimum Root Radius`
  String get rmin_label {
    return Intl.message(
      'Rmin - Minimum Root Radius',
      name: 'rmin_label',
      desc: '',
      args: [],
    );
  }

  /// `It is recommended to cross-check results with official references.`
  String get settings_header_subtitle {
    return Intl.message(
      'It is recommended to cross-check results with official references.',
      name: 'settings_header_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `About the App`
  String get about_app {
    return Intl.message('About the App', name: 'about_app', desc: '', args: []);
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `ThreadFon is your comprehensive reference for standard thread parameters.`
  String get app_description {
    return Intl.message(
      'ThreadFon is your comprehensive reference for standard thread parameters.',
      name: 'app_description',
      desc: '',
      args: [],
    );
  }

  /// `App Icon`
  String get app_icon_alt {
    return Intl.message('App Icon', name: 'app_icon_alt', desc: '', args: []);
  }

  /// `App Store not found`
  String get app_store_not_found {
    return Intl.message(
      'App Store not found',
      name: 'app_store_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Leave a Review`
  String get leave_review {
    return Intl.message(
      'Leave a Review',
      name: 'leave_review',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get no_internet {
    return Intl.message(
      'No Internet Connection',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Threads per inch`
  String get tpi {
    return Intl.message('Threads per inch', name: 'tpi', desc: '', args: []);
  }

  /// `Thread Series`
  String get thread_series {
    return Intl.message(
      'Thread Series',
      name: 'thread_series',
      desc: '',
      args: [],
    );
  }

  /// `Thread Class`
  String get thread_class {
    return Intl.message(
      'Thread Class',
      name: 'thread_class',
      desc: '',
      args: [],
    );
  }

  /// `UNR Minor Diameter`
  String get minor_diameter_unr {
    return Intl.message(
      'UNR Minor Diameter',
      name: 'minor_diameter_unr',
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
