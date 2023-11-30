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

  static String m0(date) => "${date} ərzində istehlak yoxdur";

  static String m1(total) => "Cəmi ${total}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addSpend": MessageLookupByLibrary.simpleMessage("İstehlak əlavə et"),
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
        "confirmDelete":
            MessageLookupByLibrary.simpleMessage("Əməliyyatı təsdiqləyin"),
        "dateFormat": MessageLookupByLibrary.simpleMessage("dd/MM/yyyy"),
        "delete": MessageLookupByLibrary.simpleMessage("Silmək"),
        "dialogAdd": MessageLookupByLibrary.simpleMessage("Əlavə etmək"),
        "dialogAddCategory":
            MessageLookupByLibrary.simpleMessage("Kateqoriyanı əlavə edin"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("Təsdiqləmək"),
        "dialogDate": MessageLookupByLibrary.simpleMessage("Tarix"),
        "dialogDeleteAnswer":
            MessageLookupByLibrary.simpleMessage("Silməyinizə əminsiniz?"),
        "dialogDiscard": MessageLookupByLibrary.simpleMessage("İmtina"),
        "dialogIncorrectDate":
            MessageLookupByLibrary.simpleMessage("Yalnış tarix"),
        "dialogSelectDate":
            MessageLookupByLibrary.simpleMessage("Tarixi seçin"),
        "dialogSpecifyCategoryName":
            MessageLookupByLibrary.simpleMessage("Adı qeyd edin"),
        "dialogSpecifyColor":
            MessageLookupByLibrary.simpleMessage("Rəngi qeyd edin"),
        "dialogSpecifyCons":
            MessageLookupByLibrary.simpleMessage("İstehlakı qeyd edin"),
        "dialogSpecifyText":
            MessageLookupByLibrary.simpleMessage("Mətni qeyd edin"),
        "dialogSpend": MessageLookupByLibrary.simpleMessage("İstehlak"),
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
        "homeSpends": MessageLookupByLibrary.simpleMessage("İstehlaklar"),
        "language": MessageLookupByLibrary.simpleMessage("Dil"),
        "languageList": MessageLookupByLibrary.simpleMessage(
            "English|Azərbaycanca|Русский"),
        "logoutButton": MessageLookupByLibrary.simpleMessage("Çıxış"),
        "profileAppbarTitle": MessageLookupByLibrary.simpleMessage("Profil"),
        "profileSaveText": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "spendingNotExists": m0,
        "spendsDateFormat":
            MessageLookupByLibrary.simpleMessage("dd MMMM yyyy / kk:mm"),
        "totalSpendsN": m1
      };
}
