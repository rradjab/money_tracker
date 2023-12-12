import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracker/constants/date_format.dart';

Query<Map<String, dynamic>> getQuery(
    CollectionReference<Map<String, dynamic>> collectionReference,
    String dateType,
    DateTime date) {
  return switch (dateFormat.indexOf(dateType)) {
    2 => collectionReference
        .where('added',
            isGreaterThanOrEqualTo: DateTime.utc(date.year, 1, 1, 0, 0, 0))
        .where('added',
            isLessThanOrEqualTo: DateTime.utc(date.year, 12, 31, 23, 59, 59)),
    1 => collectionReference
        .where('added',
            isGreaterThanOrEqualTo: DateTime(date.year, date.month, 1, 0, 0, 0))
        .where('added',
            isLessThanOrEqualTo:
                DateTime.utc(date.year, date.month, 31, 23, 59, 59)),
    0 => collectionReference
        .where('added',
            isGreaterThanOrEqualTo:
                DateTime.utc(date.year, date.month, date.day, 0, 0, 0))
        .where('added',
            isLessThanOrEqualTo:
                DateTime.utc(date.year, date.month, date.day, 23, 59, 59)),
    _ => collectionReference
  };
}
