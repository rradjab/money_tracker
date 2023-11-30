import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:money_tracker/providers/providers.dart';

class LocaleNotifier extends StateNotifier<String> {
  LocaleNotifier(super._state, this.ref);

  Ref ref;

  void updateLocale(String? localeCode) async {
    if (localeCode != null) {
      await ref.watch(sharedPreferencesProvider).setString('lang', localeCode);
      await S.load(Locale(localeCode));
      state = localeCode;
    }
  }
}
