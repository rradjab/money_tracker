// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(date) => "There are no expenses for specified ${date}";

  static String m1(total) => "Total ${total}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addSpend": MessageLookupByLibrary.simpleMessage("Add expense"),
        "authAccountExists":
            MessageLookupByLibrary.simpleMessage("Have an account? "),
        "authAccountNotExists":
            MessageLookupByLibrary.simpleMessage("Not registered? "),
        "authEmail": MessageLookupByLibrary.simpleMessage("E-mail"),
        "authLogin": MessageLookupByLibrary.simpleMessage("Login"),
        "authPassword": MessageLookupByLibrary.simpleMessage("Password"),
        "authRegister": MessageLookupByLibrary.simpleMessage("Register"),
        "authSignIn": MessageLookupByLibrary.simpleMessage("Sign in"),
        "authSignUp": MessageLookupByLibrary.simpleMessage("Sign up"),
        "authSubtitle": MessageLookupByLibrary.simpleMessage(
            "Your expense history is always at hand"),
        "authTitle": MessageLookupByLibrary.simpleMessage("Cost accounting"),
        "confirmDelete": MessageLookupByLibrary.simpleMessage("Confirm action"),
        "dateFormat": MessageLookupByLibrary.simpleMessage("dd/MM/yyyy"),
        "dateItems": MessageLookupByLibrary.simpleMessage("Day|Month|Year|All"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "dialogAdd": MessageLookupByLibrary.simpleMessage("Add"),
        "dialogAddCategory":
            MessageLookupByLibrary.simpleMessage("Add category"),
        "dialogConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "dialogDate": MessageLookupByLibrary.simpleMessage("Date"),
        "dialogDeleteAnswer": MessageLookupByLibrary.simpleMessage(
            "Are you sure to delete this element?"),
        "dialogDiscard": MessageLookupByLibrary.simpleMessage("Discard"),
        "dialogIncorrectDate":
            MessageLookupByLibrary.simpleMessage("Wrong date"),
        "dialogSelectDate": MessageLookupByLibrary.simpleMessage("Select date"),
        "dialogSpecifyCategoryName":
            MessageLookupByLibrary.simpleMessage("Specify name"),
        "dialogSpecifyColor":
            MessageLookupByLibrary.simpleMessage("Specify color"),
        "dialogSpecifyCons":
            MessageLookupByLibrary.simpleMessage("Specify consumption"),
        "dialogSpecifyText":
            MessageLookupByLibrary.simpleMessage("Specify text"),
        "dialogSpend": MessageLookupByLibrary.simpleMessage("Consumption"),
        "dialogWrongAmount":
            MessageLookupByLibrary.simpleMessage("Wrong amount"),
        "dialogWrongColor": MessageLookupByLibrary.simpleMessage("Wrong color"),
        "errAuthError":
            MessageLookupByLibrary.simpleMessage("Authorization error"),
        "errDisabled": MessageLookupByLibrary.simpleMessage("User disabled"),
        "errUnknown": MessageLookupByLibrary.simpleMessage("Unknown error"),
        "errUserExists":
            MessageLookupByLibrary.simpleMessage("User is already exists"),
        "errUserNotFound":
            MessageLookupByLibrary.simpleMessage("User not found"),
        "errWrongEmail": MessageLookupByLibrary.simpleMessage("Wrong e-mail"),
        "errWrongPassword":
            MessageLookupByLibrary.simpleMessage("Wrong password"),
        "homePlans": MessageLookupByLibrary.simpleMessage("Plans"),
        "homeProfile": MessageLookupByLibrary.simpleMessage("Profile"),
        "homeProfits": MessageLookupByLibrary.simpleMessage("Доходы"),
        "homeSpends": MessageLookupByLibrary.simpleMessage("Expenses"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "languageList": MessageLookupByLibrary.simpleMessage(
            "English|Azərbaycanca|Русский"),
        "logoutButton": MessageLookupByLibrary.simpleMessage("Sign out"),
        "profileAppbarTitle": MessageLookupByLibrary.simpleMessage("Profile"),
        "profileSaveText": MessageLookupByLibrary.simpleMessage("Save"),
        "spendingNotExists": m0,
        "spendsDateFormat":
            MessageLookupByLibrary.simpleMessage("dd MMMM yyyy / hh:mm"),
        "totalSpendsN": m1
      };
}
