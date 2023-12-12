import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String? id;
  String? name;
  double? cost;
  Timestamp? added;

  ItemModel({this.cost, this.id});

  ItemModel.fromJson(this.id, Map<String, dynamic> json) {
    cost = json['cost'].toDouble();
    name = json['name'];
    added = json['added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['cost'] = cost;
    return data;
  }
}
