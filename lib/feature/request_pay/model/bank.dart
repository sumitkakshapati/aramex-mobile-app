import 'package:aramex/common/model/media.dart';

class Bank {
  final int id;
  final String name;
  final Media? image;

  Bank({
    required this.id,
    required this.name,
    this.image,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      id: json["_id"],
      name: json["name"],
      image: json["media"] != null ? Media.fromJson(json["media"]) : null,
    );
  }
}
