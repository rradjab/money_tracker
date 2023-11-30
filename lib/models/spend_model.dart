import 'package:cloud_firestore/cloud_firestore.dart';

class SpendModel {
  String? id;
  double? cost;
  Timestamp? added;

  SpendModel({this.cost, this.id});

  SpendModel.fromJson(this.id, Map<String, dynamic> json) {
    cost = json['cost'].toDouble();
    added = json['added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['cost'] = cost;
    return data;
  }
}
