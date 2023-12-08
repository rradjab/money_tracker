import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracker/models/category_model.dart';
import 'package:money_tracker/providers/providers.dart';

final firebaseCategories =
    StreamProvider.autoDispose<List<CategoryModel>>((ref) {
  final user = ref.watch(authStreamProvider).value;
  final eDate = ref.watch(exploreDateProvider);
  final dateType = ref.watch(datePickerProvider);

  Future<double> getTotal(String id, DateTime eDate) async {
    double sum = 0;

    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection("categories")
            .doc(id)
            .collection("spends");

    Query<Map<String, dynamic>> query = collectionReference;

    if (dateType == 'yyyy') {
      query = collectionReference
          .where('added', isGreaterThanOrEqualTo: DateTime(eDate.year, 1, 1))
          .where('added', isLessThanOrEqualTo: DateTime(eDate.year, 12, 31));
    } else if (dateType == 'M yyyy') {
      query = collectionReference
          .where('added',
              isGreaterThanOrEqualTo: DateTime(eDate.year, eDate.month, 1))
          .where('added',
              isLessThanOrEqualTo: DateTime(eDate.year, eDate.month, 31));
    } else if (dateType == 'dd M yyyy') {
      query = collectionReference
          .where('added',
              isGreaterThanOrEqualTo:
                  DateTime.utc(eDate.year, eDate.month, eDate.day, 0, 0, 0))
          .where('added',
              isLessThanOrEqualTo:
                  DateTime.utc(eDate.year, eDate.month, eDate.day, 23, 59, 59));
    }

    await query.get().then(
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
