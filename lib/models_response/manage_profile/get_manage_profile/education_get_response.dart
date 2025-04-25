import 'dart:convert';

EducationGetResponse educationGetResponseFromJson(String str) =>
    EducationGetResponse.fromJson(json.decode(str));

String educationGetResponseToJson(EducationGetResponse data) =>
    json.encode(data.toJson());

class EducationGetResponse {
  EducationGetResponse({
    this.data,
    this.result,
  });

  List<Data>? data;
  bool? result;

  factory EducationGetResponse.fromJson(Map<String, dynamic> json) =>
      EducationGetResponse(
        // Handle null and empty cases for 'data'
        data: json["data"] != null
            ? List<Data>.from(json["data"].map((x) => Data.fromJson(x)))
            : [], // Default to an empty list if 'data' is null
        result:
            json["result"] ?? false, // Default to 'false' if 'result' is null
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "result": result,
      };

  EducationGetResponse.initialState()
      : data = [],
        result = false;
}

class Data {
  Data({
    this.id,
    this.degree,
    this.institution,
    this.start,
    this.end,
    this.present,
  });

  int? id;
  String? degree;
  String? institution;
  String? start;
  String? end;
  bool? present;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        // Ensure correct type conversion for 'id'
        id: json["id"] is int
            ? json["id"]
            : int.tryParse(json["id"].toString()) ?? 0, // Convert 'id' to int

        // Ensure all String fields are parsed correctly
        degree: json["degree"] is String
            ? json["degree"]
            : json["degree"]?.toString() ??
                "", // Default to empty string if null
        institution: json["institution"] is String
            ? json["institution"]
            : json["institution"]?.toString() ??
                "", // Default to empty string if null
        start: json["start"] is String
            ? json["start"]
            : json["start"]?.toString() ??
                "", // Default to empty string if null
        end: json["end"] is String
            ? json["end"]
            : json["end"]?.toString() ?? "", // Default to empty string if null
        present:
            json["present"] ?? false, // Default to 'false' if 'present' is null
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "degree": degree,
        "institution": institution,
        "start": start,
        "end": end,
        "present": present,
      };
}
