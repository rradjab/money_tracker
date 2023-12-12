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

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Cost accounting`
  String get authTitle {
    return Intl.message(
      'Cost accounting',
      name: 'authTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your expense history is always at hand`
  String get authSubtitle {
    return Intl.message(
      'Your expense history is always at hand',
      name: 'authSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get authPassword {
    return Intl.message(
      'Password',
      name: 'authPassword',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get authEmail {
    return Intl.message(
      'E-mail',
      name: 'authEmail',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get authLogin {
    return Intl.message(
      'Login',
      name: 'authLogin',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get authRegister {
    return Intl.message(
      'Register',
      name: 'authRegister',
      desc: '',
      args: [],
    );
  }

  /// `Not registered? `
  String get authAccountNotExists {
    return Intl.message(
      'Not registered? ',
      name: 'authAccountNotExists',
      desc: '',
      args: [],
    );
  }

  /// `Have an account? `
  String get authAccountExists {
    return Intl.message(
      'Have an account? ',
      name: 'authAccountExists',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get authSignIn {
    return Intl.message(
      'Sign in',
      name: 'authSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get authSignUp {
    return Intl.message(
      'Sign up',
      name: 'authSignUp',
      desc: '',
      args: [],
    );
  }

  /// `There are no information for specified {date}`
  String spendingNotExists(Object date) {
    return Intl.message(
      'There are no information for specified $date',
      name: 'spendingNotExists',
      desc: '',
      args: [date],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileAppbarTitle {
    return Intl.message(
      'Profile',
      name: 'profileAppbarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get profileSaveText {
    return Intl.message(
      'Save',
      name: 'profileSaveText',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get logoutButton {
    return Intl.message(
      'Sign out',
      name: 'logoutButton',
      desc: '',
      args: [],
    );
  }

  /// `Add expense`
  String get dialogAddSpend {
    return Intl.message(
      'Add expense',
      name: 'dialogAddSpend',
      desc: '',
      args: [],
    );
  }

  /// `Total {total}`
  String totalSpendsN(Object total) {
    return Intl.message(
      'Total $total',
      name: 'totalSpendsN',
      desc: '',
      args: [total],
    );
  }

  /// `Wrong e-mail`
  String get errWrongEmail {
    return Intl.message(
      'Wrong e-mail',
      name: 'errWrongEmail',
      desc: '',
      args: [],
    );
  }

  /// `User disabled`
  String get errDisabled {
    return Intl.message(
      'User disabled',
      name: 'errDisabled',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get errUserNotFound {
    return Intl.message(
      'User not found',
      name: 'errUserNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password`
  String get errWrongPassword {
    return Intl.message(
      'Wrong password',
      name: 'errWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get errUnknown {
    return Intl.message(
      'Unknown error',
      name: 'errUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Authorization error`
  String get errAuthError {
    return Intl.message(
      'Authorization error',
      name: 'errAuthError',
      desc: '',
      args: [],
    );
  }

  /// `User is already exists`
  String get errUserExists {
    return Intl.message(
      'User is already exists',
      name: 'errUserExists',
      desc: '',
      args: [],
    );
  }

  /// `Expenses`
  String get homeSpends {
    return Intl.message(
      'Expenses',
      name: 'homeSpends',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get homeProfile {
    return Intl.message(
      'Profile',
      name: 'homeProfile',
      desc: '',
      args: [],
    );
  }

  /// `Select date`
  String get dialogSelectDate {
    return Intl.message(
      'Select date',
      name: 'dialogSelectDate',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get dialogDate {
    return Intl.message(
      'Date',
      name: 'dialogDate',
      desc: '',
      args: [],
    );
  }

  /// `Wrong date`
  String get dialogIncorrectDate {
    return Intl.message(
      'Wrong date',
      name: 'dialogIncorrectDate',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get dialogConfirm {
    return Intl.message(
      'Confirm',
      name: 'dialogConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Discard`
  String get dialogDiscard {
    return Intl.message(
      'Discard',
      name: 'dialogDiscard',
      desc: '',
      args: [],
    );
  }

  /// `dd/MM/yyyy`
  String get dateFormat {
    return Intl.message(
      'dd/MM/yyyy',
      name: 'dateFormat',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete this element?`
  String get dialogDeleteAnswer {
    return Intl.message(
      'Are you sure to delete this element?',
      name: 'dialogDeleteAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Confirm action`
  String get confirmDelete {
    return Intl.message(
      'Confirm action',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Specify amount`
  String get dialogSpecifySum {
    return Intl.message(
      'Specify amount',
      name: 'dialogSpecifySum',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get dialogAmount {
    return Intl.message(
      'Amount',
      name: 'dialogAmount',
      desc: '',
      args: [],
    );
  }

  /// `Specify text`
  String get dialogSpecifyText {
    return Intl.message(
      'Specify text',
      name: 'dialogSpecifyText',
      desc: '',
      args: [],
    );
  }

  /// `Wrong amount`
  String get dialogWrongAmount {
    return Intl.message(
      'Wrong amount',
      name: 'dialogWrongAmount',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get dialogAdd {
    return Intl.message(
      'Add',
      name: 'dialogAdd',
      desc: '',
      args: [],
    );
  }

  /// `Add category`
  String get dialogAddCategory {
    return Intl.message(
      'Add category',
      name: 'dialogAddCategory',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get dialogName {
    return Intl.message(
      'Name',
      name: 'dialogName',
      desc: '',
      args: [],
    );
  }

  /// `Wrong color`
  String get dialogWrongColor {
    return Intl.message(
      'Wrong color',
      name: 'dialogWrongColor',
      desc: '',
      args: [],
    );
  }

  /// `Specify color`
  String get dialogSpecifyColor {
    return Intl.message(
      'Specify color',
      name: 'dialogSpecifyColor',
      desc: '',
      args: [],
    );
  }

  /// `dd MMMM yyyy / hh:mm`
  String get spendsDateFormat {
    return Intl.message(
      'dd MMMM yyyy / hh:mm',
      name: 'spendsDateFormat',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Plans`
  String get homePlans {
    return Intl.message(
      'Plans',
      name: 'homePlans',
      desc: '',
      args: [],
    );
  }

  /// `English|Azərbaycanca|Русский`
  String get languageList {
    return Intl.message(
      'English|Azərbaycanca|Русский',
      name: 'languageList',
      desc: '',
      args: [],
    );
  }

  /// `Day|Month|Year|All`
  String get dateItems {
    return Intl.message(
      'Day|Month|Year|All',
      name: 'dateItems',
      desc: '',
      args: [],
    );
  }

  /// `Profits`
  String get homeProfits {
    return Intl.message(
      'Profits',
      name: 'homeProfits',
      desc: '',
      args: [],
    );
  }

  /// `Add plan`
  String get dialogAddPlan {
    return Intl.message(
      'Add plan',
      name: 'dialogAddPlan',
      desc: '',
      args: [],
    );
  }

  /// `Already implemented?`
  String get dialogIsRealised {
    return Intl.message(
      'Already implemented?',
      name: 'dialogIsRealised',
      desc: '',
      args: [],
    );
  }

  /// `Specify category`
  String get dialogSpecifyCategory {
    return Intl.message(
      'Specify category',
      name: 'dialogSpecifyCategory',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get dialogCategory {
    return Intl.message(
      'Category',
      name: 'dialogCategory',
      desc: '',
      args: [],
    );
  }

  /// `Новая категория`
  String get dialogNewCategory {
    return Intl.message(
      'Новая категория',
      name: 'dialogNewCategory',
      desc: '',
      args: [],
    );
  }

  /// `Остаток`
  String get dialogRemainder {
    return Intl.message(
      'Остаток',
      name: 'dialogRemainder',
      desc: '',
      args: [],
    );
  }

  /// `Добавить доход`
  String get dialogAddProfit {
    return Intl.message(
      'Добавить доход',
      name: 'dialogAddProfit',
      desc: '',
      args: [],
    );
  }

  /// `Balance {sum}`
  String balanceSum(Object sum) {
    return Intl.message(
      'Balance $sum',
      name: 'balanceSum',
      desc: '',
      args: [sum],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'az'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
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
