import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FireStorePlansService extends StateNotifier<String> {
  FireStorePlansService() : super('');

  final user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addPlan(String name, String cost, Timestamp timestamp) async {
    try {
      final documentReference = firestore
          .collection('users')
          .doc(user!.uid)
          .collection('plans')
          .doc();

      await documentReference.set({
        "name": name,
        "cost": double.tryParse(cost) ?? 0,
        "added": timestamp,
      });
    } catch (e) {
      // ignore: avoid_print
      print('----$e');
    }
  }

  void deletePlan(String planId) async {
    try {
      DocumentReference documentReference = firestore
          .collection('users')
          .doc(user!.uid)
          .collection('plans')
          .doc(planId);

      await documentReference.delete();
    } catch (e) {
      // ignore: avoid_print
      print('----$e');
    }
  }
}
