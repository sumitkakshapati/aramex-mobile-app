class Media {
  final int id;
  final String mimeType;
  final String path;

  Media({required this.id, required this.mimeType, required this.path});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json["_id"],
      mimeType: json["mime_type"],
      path: json["path"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "mime_type": mimeType,
      "path": path,
    };
  }
}
