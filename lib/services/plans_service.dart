import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracker/models/plan_model.dart';
import 'package:money_tracker/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebasePlans = StreamProvider.autoDispose<List<PlanModel>>((ref) {
  final user = ref.watch(authStreamProvider).value;
  final eDate = ref.watch(exploreDateProvider);
  final dateType = ref.watch(datePickerProvider);

  CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("plans");

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

  Stream<QuerySnapshot<Map<String, dynamic>>> stream =
      query.orderBy('added', descending: true).snapshots();

  return stream.map((snapshot) => snapshot.docs.map((doc) {
        return PlanModel.fromJson(doc.id, doc.data());
      }).toList());
});
