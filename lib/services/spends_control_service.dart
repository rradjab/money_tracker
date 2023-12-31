import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpendsService extends StateNotifier<String> {
  SpendsService() : super('');

  final user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> addCategory(String name, String color) async {
    try {
      CollectionReference collectionReference =
          firestore.collection('users').doc(user!.uid).collection('categories');

      await collectionReference.doc().set({
        "name": name,
        "color": color,
        "total": 0.0,
      });

      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("categories")
          .where("name", isEqualTo: name)
          .get();

      return querySnapshot.docs.isNotEmpty ? querySnapshot.docs[0].id : '';
    } catch (e) {
      // ignore: avoid_print
      print('----$e');
    }
    return '';
  }

  void deleteCategory(String categoryId) async {
    try {
      DocumentReference documentReference = firestore
          .collection('users')
          .doc(user!.uid)
          .collection('categories')
          .doc(categoryId);

      await _deleteCategorySubcollections(documentReference);

      await documentReference.delete();
    } catch (e) {
      // ignore: avoid_print
      print('----$e');
    }
  }

  Future<void> _deleteCategorySubcollections(
      DocumentReference documentReference) async {
    QuerySnapshot subcollections =
        await documentReference.collection('spends').get();

    // Рекурсивно удалите каждую подколлекцию
    for (QueryDocumentSnapshot subcollection in subcollections.docs) {
      await _deleteCategorySubcollections(subcollection.reference);
      await subcollection.reference.delete();
    }
  }

  void deleteSpend(String categoryId, String spendId) async {
    try {
      final documentReference = firestore
          .collection('users')
          .doc(user!.uid)
          .collection('categories')
          .doc(categoryId);

      await documentReference.collection('spends').doc(spendId).delete();

      await documentReference.update({
        "updated": Timestamp.now(),
      });
    } catch (e) {
      // ignore: avoid_print
      print('----$e');
    }
  }

  void addItem(
      String categoryId, String name, String cost, Timestamp timestamp) async {
    try {
      final documentReference = firestore
          .collection('users')
          .doc(user!.uid)
          .collection('categories')
          .doc(categoryId);

      await documentReference.collection('spends').doc().set({
        "name": name,
        "cost": double.tryParse(cost) ?? 0,
        "added": timestamp,
      });

      await documentReference.update({
        "updated": Timestamp.now(),
      });
    } catch (e) {
      // ignore: avoid_print
      print('----$e');
    }
  }
}
