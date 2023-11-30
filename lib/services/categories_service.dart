import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracker/models/category_model.dart';
import 'package:money_tracker/providers/providers.dart';

final firebaseCategories =
    StreamProvider.autoDispose<List<CategoryModel>>((ref) {
  final user = ref.watch(authStreamProvider).value;
  final eDate = ref.watch(exploreDateProvider);

  Future<double> getTotal(String id, DateTime eDate) async {
    double sum = 0;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection("categories")
        .doc(id)
        .collection("spends")
        .where('added',
            isGreaterThanOrEqualTo: DateTime(eDate.year, eDate.month, 1))
        .where('added',
            isLessThanOrEqualTo: DateTime(eDate.year, eDate.month, 31))
        .get()
        .then(
      (querSnapshot) {
        for (final doc in querSnapshot.docs) {
          sum += (doc.data())["cost"] as num;
        }
      },
    );
    return sum;
  }

  Future<CategoryModel> getCategoryModel(
      QueryDocumentSnapshot<Map<String, dynamic>> json) async {
    return CategoryModel.fromJson(
        json.id, json.data(), await getTotal(json.id, eDate));
  }

  Stream<List<CategoryModel>> stream = FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .collection("categories")
      .orderBy('name', descending: false)
      .snapshots()
      .asyncMap((snapshot) =>
          Future.wait(snapshot.docs.map((e) => getCategoryModel(e))));

  return stream;
});