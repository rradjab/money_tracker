// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a az locale. All the
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
  String get localeName => 'az';

  static String m0(sum) => "Balans ${sum}";

  static String m1(date) =>
      "Qeyd olunan ${date} ərzində heç bir məlumat yoxdur";

  static String m2(total) => "Cəmi ${total}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "authAccountExists":
            MessageLookupByLibrary.simpleMessage("Qeydiyyatdan keçmisiniz? "),
        "authAccountNotExists":
            MessageLookupByLibrary.simpleMessage("Qeydiyyatdan keçməmisiniz? "),
        "authEmail": MessageLookupByLibrary.simpleMessage("E-mail"),
        "authLogin": MessageLookupByLibrary.simpleMessage("Daxil olmaq"),
        "authPassword": MessageLookupByLibrary.simpleMessage("Parol"),
        "authRegister": MessageLookupByLibrary.simpleMessage("Qeydiyyat"),
        "authSignIn": MessageLookupByLibrary.simpleMessage("Daxil olun"),
        "authSignUp": MessageLookupByLibrary.simpleMessage("Qeydiyyat"),
        "authSubtitle": MessageLookupByLibrary.simpleMessage(
            "Sizin istehlak tarixçəsi hər zaman əlinizin altıdadır"),
        "authTitle": MessageLookupByLibrary.simpleMessage("İstehlak tarixçəsi"),
        "balanceSum": m0,
        "confirmDelete":
            MessageLookupByLibrary.simpleMessage("Əməliyyatı təsdiqləyin"),
        "dateFormat": MessageLookupByLibrary.simpleMessage("dd/MM/yyyy"),
        "dateItems": MessageLookupByLibrary.simpleMessage("Gün|Ay|İl|Hamısı"),
        "delete": MessageLookupByLibrary.simpleMessage("Silmək"),
        "dialogAdd": MessageLookupByLibrary.simpleMessage("Əlavə etmək"),
        "dialogAddCategory":
            MessageLookupByLibrary.simpleMessage("Kateqoriyanı əlavə edin"),
        "dialogAddPlan":
            MessageLookupByLibrary.simpleMessage("Plan əlavə etmək"),
        "dialogAddProfit":
            MessageLookupByLibrary.simpleMessage("Добавить доход"),
        "dialogAddSpend":
            MessageLookupByLibrary.simpleMessage("İstehlak əlavə et"),
        "dialogAmount": MessageLookupByLibrary.simpleMessage("Məbləğ"),
        "dialogCategory": MessageLookupByLibrary.simpleMessage("Kateqoriya"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("Təsdiqləmək"),
        "dialogDate": MessageLookupByLibrary.simpleMessage("Tarix"),
        "dialogDeleteAnswer":
            MessageLookupByLibrary.simpleMessage("Silməyinizə əminsiniz?"),
        "dialogDiscard": MessageLookupByLibrary.simpleMessage("İmtina"),
        "dialogIncorrectDate":
            MessageLookupByLibrary.simpleMessage("Yalnış tarix"),
        "dialogIsRealised":
            MessageLookupByLibrary.simpleMessage("Artıq həyata keçirilib?"),
        "dialogName": MessageLookupByLibrary.simpleMessage("Ad"),
        "dialogNewCategory":
            MessageLookupByLibrary.simpleMessage("Новая категория"),
        "dialogRemainder": MessageLookupByLibrary.simpleMessage("Остаток"),
        "dialogSelectDate":
            MessageLookupByLibrary.simpleMessage("Tarixi seçin"),
        "dialogSpecifyCategory":
            MessageLookupByLibrary.simpleMessage("Kateqoriyanı seçin"),
        "dialogSpecifyColor":
            MessageLookupByLibrary.simpleMessage("Rəngi qeyd edin"),
        "dialogSpecifySum":
            MessageLookupByLibrary.simpleMessage("Məbləği qeyd edin"),
        "dialogSpecifyText":
            MessageLookupByLibrary.simpleMessage("Mətni qeyd edin"),
        "dialogWrongAmount":
            MessageLookupByLibrary.simpleMessage("Yalnış məbləğ"),
        "dialogWrongColor": MessageLookupByLibrary.simpleMessage("Yalnış rəng"),
        "errAuthError":
            MessageLookupByLibrary.simpleMessage("Qeydiyyatda səhv"),
        "errDisabled":
            MessageLookupByLibrary.simpleMessage("İstifadəçi dondurulub"),
        "errUnknown": MessageLookupByLibrary.simpleMessage("Naməlum səhv"),
        "errUserExists":
            MessageLookupByLibrary.simpleMessage("İstifadəçi artıq mövcuddur"),
        "errUserNotFound":
            MessageLookupByLibrary.simpleMessage("İstifadəçi tapılmadı"),
        "errWrongEmail": MessageLookupByLibrary.simpleMessage("Yalnış e-mail"),
        "errWrongPassword":
            MessageLookupByLibrary.simpleMessage("Yalnış parol"),
        "homePlans": MessageLookupByLibrary.simpleMessage("Planlar"),
        "homeProfile": MessageLookupByLibrary.simpleMessage("Profil"),
        "homeProfits": MessageLookupByLibrary.simpleMessage("Gəlirlər"),
        "homeSpends": MessageLookupByLibrary.simpleMessage("İstehlaklar"),
        "language": MessageLookupByLibrary.simpleMessage("Dil"),
        "languageList": MessageLookupByLibrary.simpleMessage(
            "English|Azərbaycanca|Русский"),
        "logoutButton": MessageLookupByLibrary.simpleMessage("Çıxış"),
        "profileAppbarTitle": MessageLookupByLibrary.simpleMessage("Profil"),
        "profileSaveText": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "spendingNotExists": m1,
        "spendsDateFormat":
            MessageLookupByLibrary.simpleMessage("dd MMMM yyyy / HH:mm"),
        "totalSpendsN": m2
      };
}
