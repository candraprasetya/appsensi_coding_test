part of 'models.dart';
// To parse this JSON data, do
//
//     final listResponseModel = listResponseModelFromMap(jsonString);

ListResponseModel listResponseModelFromMap(String str) =>
    ListResponseModel.fromMap(json.decode(str));

String listResponseModelToMap(ListResponseModel data) =>
    json.encode(data.toMap());

class ListResponseModel {
  ListResponseModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  final int? page;
  final List<dynamic>? results;
  final int? totalPages;
  final int? totalResults;

  factory ListResponseModel.fromMap(Map<String, dynamic> json) =>
      ListResponseModel(
        page: json["page"],
        results: List<dynamic>.from(json["results"].map((x) => x)),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "results": List<dynamic>.from(results!.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
