import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracker/constants/queries.dart';
import 'package:money_tracker/models/item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/providers/providers.dart';
import 'package:money_tracker/models/category_model.dart';
import 'package:money_tracker/providers/spends/providers.dart';
import 'package:money_tracker/services/profits_control_service.dart';

// final profitsDatePickerProvider = StateProvider<String>((ref) => 'M.yyyy');

// final profitsExpDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final firebaseProfitsControl =
    StateNotifierProvider<ProfitsService, String>((ref) => ProfitsService());

final profitsCategoriesStreamProvider =
    StreamProvider.autoDispose<List<CategoryModel>>((ref) {
  final user = ref.watch(authStreamProvider).value;
  final eDate = ref.watch(spendsDateProvider);
  final dateType = ref.watch(spendsDatePickerProvider);

  Future<double> getTotal(String id, DateTime eDate) async {
    double sum = 0;

    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection("profitCategories")
            .doc(id)
            .collection("profits");

    Query<Map<String, dynamic>> query =
        getQuery(collectionReference, dateType, eDate);

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
      .collection("profitCategories")
      .orderBy('name', descending: false)
      .snapshots()
      .asyncMap((snapshot) =>
          Future.wait(snapshot.docs.map((e) => getCategoryModel(e))));

  return stream;
});

final profitsStreamProvider = StreamProvider.autoDispose
    .family<List<ItemModel>, String>((ref, categoryId) {
  final user = ref.watch(authStreamProvider).value;
  final eDate = ref.watch(spendsDateProvider);
  final dateType = ref.watch(spendsDatePickerProvider);

  CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("profitCategories")
          .doc(categoryId)
          .collection("profits");

  Query<Map<String, dynamic>> query =
      getQuery(collectionReference, dateType, eDate);

  Stream<QuerySnapshot<Map<String, dynamic>>> stream =
      query.orderBy('added', descending: true).snapshots();

  return stream.map((snapshot) => snapshot.docs.map((doc) {
        return ItemModel.fromJson(doc.id, doc.data());
      }).toList());
});
