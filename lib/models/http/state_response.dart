import 'dart:convert';

class Status {
  Status({
    required this.status,
  });

  bool status;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
      };
}
