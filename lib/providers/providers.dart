import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/services/auth_service.dart';
import 'package:money_tracker/services/image_service.dart';
import 'package:money_tracker/services/locale_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:money_tracker/services/spends_control_service.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final firebaseAuthInstanceProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStreamProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthInstanceProvider).userChanges());

final spendDateProvider = StateProvider<DateTime?>((ref) => DateTime.now());

final exploreDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final isRegisteredProvider = StateProvider<bool>((ref) => true);

final localeProvider = StateNotifierProvider<LocaleNotifier, String>((ref) =>
    LocaleNotifier(
        ref.watch(sharedPreferencesProvider).getString('lang') ?? 'ru', ref));

final profileImageProvider =
    StateNotifierProvider<ProfileImageNotifier, Uint8List?>(
        (ref) => ProfileImageNotifier());

final firebaseAuthProvider =
    StateNotifierProvider<FireStoreAuthService, String?>(
        (ref) => FireStoreAuthService());

final firebaseSpendsControl =
    StateNotifierProvider<FireStoreSpendsService, String>(
        (ref) => FireStoreSpendsService());
