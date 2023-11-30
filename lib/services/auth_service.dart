import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FireStoreAuthService extends StateNotifier<String?> {
  FireStoreAuthService() : super(null);
  final auth = FirebaseAuth.instance;

  void loginUser(String email, String password) async {
    state = '';
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      state = null;
    } on FirebaseAuthException catch (e) {
      state = switch (e.code) {
        "invalid-email" => S.current.errWrongEmail,
        "user-disabled" => S.current.errDisabled,
        "user-not-found" => S.current.errUserNotFound,
        "wrong-password" => S.current.errWrongPassword,
        _ => S.current.errUnknown,
      };
    } catch (e) {
      state = S.current.errAuthError;
    }
  }

  void createUser(String email, String password) async {
    state = '';
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      state = null;
    } on FirebaseAuthException catch (e) {
      state = switch (e.code) {
        "email-already-in-use" => S.current.errUserExists,
        "invalid-email" => S.current.errWrongEmail,
        "weak-password" => S.current.errWrongPassword,
        _ => S.current.errUnknown,
      };
    } catch (e) {
      state = S.current.errAuthError;
    }
  }

  void signOut() {
    auth.signOut();
  }
}
