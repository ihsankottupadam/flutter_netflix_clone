// To parse this JSON data, do
//
//     final serchResult = serchResultFromJson(jsonString);

import 'dart:convert';

List<SearchResult> searchResultFromJson(String str) => List<SearchResult>.from(
    json.decode(str).map((x) => SearchResult.fromJson(x)));

String searchResultToJson(List<SearchResult> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchResult {
  SearchResult({
    required this.kind,
    required this.etag,
    required this.id,
  });

  final String kind;
  final String etag;
  final Id id;

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        kind: json["kind"],
        etag: json["etag"],
        id: Id.fromJson(json["id"]),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "id": id.toJson(),
      };
}

class Id {
  Id({
    required this.kind,
    required this.playlistId,
    required this.channelId,
    required this.videoId,
  });

  final String kind;
  final String? playlistId;
  final String? channelId;
  final String? videoId;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        kind: json["kind"],
        playlistId: json["playlistId"],
        channelId: json["channelId"],
        videoId: json["videoId"],
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "playlistId": playlistId,
        "channelId": channelId,
        "videoId": videoId,
      };
}
