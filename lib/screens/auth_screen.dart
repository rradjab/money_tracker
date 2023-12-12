import 'package:flutter/material.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/providers/providers.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(48.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Image.asset('assets/icons/wallet.png',
                              fit: BoxFit.contain),
                        ),
                        Text(
                          S.current.authTitle,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28.0),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            width: 200,
                            child: Text(
                              S.current.authSubtitle,
                              style: const TextStyle(fontSize: 12.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        controller: userNameController,
                        decoration:
                            InputDecoration(labelText: S.current.authEmail),
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration:
                            InputDecoration(labelText: S.current.authPassword),
                      ),
                    ],
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final isRegistered = ref.watch(isRegisteredProvider);
                    final isAuth = ref.watch(firebaseAuthProvider);
                    final auth = ref.read(firebaseAuthProvider.notifier);

                    return Expanded(
                      flex: 3,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          if (isAuth != null)
                            Text(
                              isAuth,
                              style: const TextStyle(color: Colors.red),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                minimumSize: const Size.fromHeight(40),
                              ),
                              onPressed: () {
                                if (userNameController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  isRegistered
                                      ? auth.loginUser(userNameController.text,
                                          passwordController.text)
                                      : auth.createUser(userNameController.text,
                                          passwordController.text);
                                }
                              },
                              child: (isAuth != null && isAuth.isEmpty)
                                  ? const SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(),
                                    )
                                  : Text(
                                      isRegistered
                                          ? S.current.authLogin
                                          : S.current.authRegister,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  isRegistered
                                      ? S.current.authAccountNotExists
                                      : S.current.authAccountExists,
                                  style: const TextStyle(fontSize: 17.0),
                                ),
                                InkWell(
                                  onTap: () {
                                    ref
                                        .read(isRegisteredProvider.notifier)
                                        .update((state) => !isRegistered);
                                  },
                                  child: Text(
                                    isRegistered
                                        ? S.current.authSignUp
                                        : S.current.authSignIn,
                                    style: const TextStyle(
                                        fontSize: 17.0, color: Colors.purple),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
