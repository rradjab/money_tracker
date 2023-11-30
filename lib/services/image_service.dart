import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileImageNotifier extends StateNotifier<Uint8List?> {
  ProfileImageNotifier() : super(null);

  final auth = FirebaseAuth.instance;
  Uint8List? fileBytes;

  void checkForProfileImage() async {
    String? photoUrl = FirebaseAuth.instance.currentUser!.photoURL;

    if (photoUrl != null && fileBytes == null) {
      try {
        fileBytes = await http
            .get(Uri.parse(photoUrl))
            .then((response) => response.bodyBytes);
        state = fileBytes;
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  Future<bool> getImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
        withData: true);

    if (result != null) {
      state = result.files.first.bytes;
      return true;
    } else {
      return false;
    }
  }

  void updateProfileImage() async {
    try {
      if (state != null) {
        final reference = FirebaseStorage.instance
            .ref()
            .child('images')
            .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');

        UploadTask uploadTask = reference.putData(state!);
        TaskSnapshot snapshot = await uploadTask;
        String imageUrl = await snapshot.ref.getDownloadURL();
        await FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl);
        fileBytes = null;
      }
    } catch (e) {
      // ignore: avoid_print
      print('--------$e');
    }

    checkForProfileImage();
  }
}
