import 'dart:convert';

class Product {
  final String code;
  final String title;
  final String description;
  final DateTime created;
  final DateTime updated;
  final List<String> imagePath;

  Product({
    required this.code,
    required this.title,
    required this.description,
    required this.created,
    required this.updated,
    required this.imagePath,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      code: json["code"],
      title: json["title"],
      description: json["description"],
      created: DateTime.fromMillisecondsSinceEpoch(json["created"]),
      updated: DateTime.fromMillisecondsSinceEpoch(json["updated"]),
      imagePath: json["imagePath"] != null
          ? List<String>.from(jsonDecode(json["imagePath"]))
          : <String>[],
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "title": title,
        "description": description,
        "created": created.millisecondsSinceEpoch,
        "updated": updated.millisecondsSinceEpoch,
        "imagePath": jsonEncode(imagePath),
      };
}
