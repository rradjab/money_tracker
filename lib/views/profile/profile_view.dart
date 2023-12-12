import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:money_tracker/providers/providers.dart';

class ProfileWidget extends ConsumerStatefulWidget {
  const ProfileWidget({super.key});

  @override
  ConsumerState<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends ConsumerState<ProfileWidget> {
  bool notSaved = false;
  final List<String> languages = S.current.languageList.split('|');

  @override
  void initState() {
    ref.read(profileImageProvider.notifier).checkForProfileImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileImageBytes = ref.watch(profileImageProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.profileAppbarTitle),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InkWell(
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.grey[300],
                      child: (profileImageBytes != null &&
                              profileImageBytes.length > 100)
                          ? ClipPath(
                              clipper: const ShapeBorderClipper(
                                shape: CircleBorder(),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Image.memory(
                                profileImageBytes,
                                fit: BoxFit.fill,
                                height: 200,
                                width: 200,
                              ),
                            )
                          : const FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.photo_camera,
                              ),
                            ),
                    ),
                    onTap: () async {
                      notSaved = await ref
                          .read(profileImageProvider.notifier)
                          .getImageFromGallery();
                    },
                  ),
                  if (notSaved)
                    InkWell(
                      onTap: () {
                        notSaved = false;
                        ref
                            .read(profileImageProvider.notifier)
                            .updateProfileImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.current.profileSaveText,
                          style: const TextStyle(
                              fontSize: 17.0, color: Colors.purple),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.language,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            child: DropdownButton(
                              value: ref.watch(localeProvider),
                              isDense: true,
                              items: [
                                for (int i = 0;
                                    i < S.delegate.supportedLocales.length;
                                    i++)
                                  DropdownMenuItem(
                                      value: S.delegate.supportedLocales[i]
                                          .languageCode,
                                      child: Text(
                                          S.current.languageList.split('|')[i]))
                              ],
                              onChanged: (v) {
                                ref
                                    .read(localeProvider.notifier)
                                    .updateLocale(v);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            ref.watch(authStreamProvider).value!.email!,
                            style: const TextStyle(fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () {
                              ref.read(firebaseAuthProvider.notifier).signOut();
                            },
                            child: Text(S.current.logoutButton),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
