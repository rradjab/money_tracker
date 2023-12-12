import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracker/constants/queries.dart';
import 'package:money_tracker/models/plan_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/providers/providers.dart';
import 'package:money_tracker/services/plans_control_service.dart';

final plansDatePickerProvider = StateProvider<String>((ref) => 'M.yyyy');

final plansExpDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final firebasePlansControl =
    StateNotifierProvider<PlansService, String>((ref) => PlansService());

final firebasePlans = StreamProvider.autoDispose<List<PlanModel>>((ref) {
  final user = ref.watch(authStreamProvider).value;
  final eDate = ref.watch(plansExpDateProvider);
  final dateType = ref.watch(plansDatePickerProvider);

  CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("plans");

  Query<Map<String, dynamic>> query =
      getQuery(collectionReference, dateType, eDate);

  Stream<QuerySnapshot<Map<String, dynamic>>> stream =
      query.orderBy('added', descending: true).snapshots();

  return stream.map((snapshot) => snapshot.docs.map((doc) {
        return PlanModel.fromJson(doc.id, doc.data());
      }).toList());
});
