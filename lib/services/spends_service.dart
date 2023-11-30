import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/models/spend_model.dart';
import 'package:money_tracker/providers/providers.dart';

final firebaseSpends = StreamProvider.autoDispose
    .family<List<SpendModel>, String>((ref, categoryId) {
  final user = ref.watch(authStreamProvider).value;
  final expDate = ref.watch(exploreDateProvider);

  Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore
      .instance
      .collection('users')
      .doc(user!.uid)
      .collection("categories")
      .doc(categoryId)
      .collection("spends")
      .where('added',
          isGreaterThanOrEqualTo: DateTime(expDate.year, expDate.month, 1))
      .where('added',
          isLessThanOrEqualTo: DateTime(expDate.year, expDate.month, 31))
      .orderBy('added', descending: true)
      .snapshots();

  return stream.map((snapshot) => snapshot.docs.map((doc) {
        return SpendModel.fromJson(doc.id, doc.data());
      }).toList());
});
