class CategoryModel {
  String? id;
  String? name;
  double? total;
  String? color;

  CategoryModel({this.name, this.total, this.color, this.id});

  CategoryModel.fromJson(
      this.id, Map<String, dynamic> json, double this.total) {
    name = json['name'] ?? '';
    color = json['color'] ?? 0xffffff;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['color'] = color;
    return data;
  }
}
