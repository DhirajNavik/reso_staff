// To parse this JSON data, do
//
//     final repoResponse = repoResponseFromJson(jsonString);

import 'dart:convert';

RepoResponse repoResponseFromJson(String str) =>
    RepoResponse.fromJson(json.decode(str));

String repoResponseToJson(RepoResponse data) => json.encode(data.toJson());

class RepoResponse {
  bool? status;
  List<RepoDatum>? data;
  String? message;

  RepoResponse({
    this.status,
    this.data,
    this.message,
  });

  factory RepoResponse.fromJson(Map<String, dynamic> json) => RepoResponse(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<RepoDatum>.from(
                json["data"]!.map((x) => RepoDatum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class RepoDatum {
  String? url;

  RepoDatum({
    this.url,
  });

  factory RepoDatum.fromJson(Map<String, dynamic> json) => RepoDatum(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
