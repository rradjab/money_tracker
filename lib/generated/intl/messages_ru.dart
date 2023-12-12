// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  static String m0(sum) => "Баланс ${sum}";

  static String m1(date) => "За указанный ${date} нет информации";

  static String m2(total) => "Всего ${total}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "authAccountExists":
            MessageLookupByLibrary.simpleMessage("Уже есть аккаунт? "),
        "authAccountNotExists":
            MessageLookupByLibrary.simpleMessage("Еще нет аккаунта? "),
        "authEmail": MessageLookupByLibrary.simpleMessage("E-mail"),
        "authLogin": MessageLookupByLibrary.simpleMessage("Войти"),
        "authPassword": MessageLookupByLibrary.simpleMessage("Пароль"),
        "authRegister": MessageLookupByLibrary.simpleMessage("Регистрация"),
        "authSignIn": MessageLookupByLibrary.simpleMessage("Войдите"),
        "authSignUp": MessageLookupByLibrary.simpleMessage("Регистрация"),
        "authSubtitle": MessageLookupByLibrary.simpleMessage(
            "Ваша история расходов всегда под рукой"),
        "authTitle": MessageLookupByLibrary.simpleMessage("Учёт расходов"),
        "balanceSum": m0,
        "confirmDelete":
            MessageLookupByLibrary.simpleMessage("Подтвердите действие"),
        "dateFormat": MessageLookupByLibrary.simpleMessage("dd/MM/yyyy"),
        "dateItems": MessageLookupByLibrary.simpleMessage("День|Месяц|Год|Все"),
        "delete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "dialogAdd": MessageLookupByLibrary.simpleMessage("Добавить"),
        "dialogAddCategory":
            MessageLookupByLibrary.simpleMessage("Добавить категорию"),
        "dialogAddPlan": MessageLookupByLibrary.simpleMessage("Добавить план"),
        "dialogAddProfit":
            MessageLookupByLibrary.simpleMessage("Добавить доход"),
        "dialogAddSpend":
            MessageLookupByLibrary.simpleMessage("Добавить расход"),
        "dialogAmount": MessageLookupByLibrary.simpleMessage("Сумма"),
        "dialogCategory": MessageLookupByLibrary.simpleMessage("Категория"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
        "dialogDate": MessageLookupByLibrary.simpleMessage("Дата"),
        "dialogDeleteAnswer": MessageLookupByLibrary.simpleMessage(
            "Уверены удалить этот элемент?"),
        "dialogDiscard": MessageLookupByLibrary.simpleMessage("Отмена"),
        "dialogIncorrectDate":
            MessageLookupByLibrary.simpleMessage("Некорректная дата"),
        "dialogIsRealised":
            MessageLookupByLibrary.simpleMessage("Уже реализовано?"),
        "dialogName": MessageLookupByLibrary.simpleMessage("Название"),
        "dialogNewCategory":
            MessageLookupByLibrary.simpleMessage("Новая категория"),
        "dialogRemainder": MessageLookupByLibrary.simpleMessage("Остаток"),
        "dialogSelectDate":
            MessageLookupByLibrary.simpleMessage("Выберите дату"),
        "dialogSpecifyCategory":
            MessageLookupByLibrary.simpleMessage("Укажите категорию"),
        "dialogSpecifyColor":
            MessageLookupByLibrary.simpleMessage("Укажите цвет"),
        "dialogSpecifySum":
            MessageLookupByLibrary.simpleMessage("Укажите сумму"),
        "dialogSpecifyText":
            MessageLookupByLibrary.simpleMessage("Укажите текст"),
        "dialogWrongAmount":
            MessageLookupByLibrary.simpleMessage("Неправильная сумма"),
        "dialogWrongColor":
            MessageLookupByLibrary.simpleMessage("Неправильный цвет"),
        "errAuthError":
            MessageLookupByLibrary.simpleMessage("Ошибка авторизации"),
        "errDisabled":
            MessageLookupByLibrary.simpleMessage("Пользователь заморожен"),
        "errUnknown":
            MessageLookupByLibrary.simpleMessage("Неизвестная ошибка"),
        "errUserExists":
            MessageLookupByLibrary.simpleMessage("Пользователь уже существует"),
        "errUserNotFound":
            MessageLookupByLibrary.simpleMessage("Пользователь не найден"),
        "errWrongEmail":
            MessageLookupByLibrary.simpleMessage("Неправильный e-mail"),
        "errWrongPassword":
            MessageLookupByLibrary.simpleMessage("Неправильный пароль"),
        "homePlans": MessageLookupByLibrary.simpleMessage("Планы"),
        "homeProfile": MessageLookupByLibrary.simpleMessage("Профиль"),
        "homeProfits": MessageLookupByLibrary.simpleMessage("Доходы"),
        "homeSpends": MessageLookupByLibrary.simpleMessage("Расходы"),
        "language": MessageLookupByLibrary.simpleMessage("Язык"),
        "languageList": MessageLookupByLibrary.simpleMessage(
            "English|Azərbaycanca|Русский"),
        "logoutButton": MessageLookupByLibrary.simpleMessage("Выйти"),
        "profileAppbarTitle": MessageLookupByLibrary.simpleMessage("Профиль"),
        "profileSaveText": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "spendingNotExists": m1,
        "spendsDateFormat":
            MessageLookupByLibrary.simpleMessage("dd MMMM yyyy / HH:mm"),
        "totalSpendsN": m2
      };
}
