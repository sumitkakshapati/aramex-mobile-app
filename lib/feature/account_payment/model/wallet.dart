import 'package:aramex/common/model/media.dart';

class Wallet {
  final int id;
  final String name;
  final Media? media;

  Wallet({required this.id, required this.name, this.media});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json["_id"],
      name: json["name"],
      media: json["media"] != null ? Media.fromJson(json["media"]) : null,
    );
  }
}
