// To parse this JSON data, do
//
//     final lessonDetail = lessonDetailFromJson(jsonString);

import 'dart:convert';

LessonDetailResponse lessonDetailFromJson(String str) =>
    LessonDetailResponse.fromJson(json.decode(str));

String lessonDetailToJson(LessonDetailResponse data) =>
    json.encode(data.toJson());

class LessonDetailResponse {
  LessonDetail? message;

  LessonDetailResponse({
    this.message,
  });

  factory LessonDetailResponse.fromJson(Map<String, dynamic> json) =>
      LessonDetailResponse(
        message: json["message"] == null
            ? null
            : LessonDetail.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class LessonDetail {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? title;
  int? includeInPreview;
  String? chapter;
  int? isScormPackage;
  String? course;
  String? content;
  String? body;
  String? fileType;
  String? doctype;
  List<CustomLessonVideo>? customLessonVideos;

  LessonDetail({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.docstatus,
    this.idx,
    this.title,
    this.includeInPreview,
    this.chapter,
    this.isScormPackage,
    this.course,
    this.content,
    this.body,
    this.fileType,
    this.doctype,
    this.customLessonVideos,
  });

  factory LessonDetail.fromJson(Map<String, dynamic> json) => LessonDetail(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        docstatus: json["docstatus"],
        idx: json["idx"],
        title: json["title"],
        includeInPreview: json["include_in_preview"],
        chapter: json["chapter"],
        isScormPackage: json["is_scorm_package"],
        course: json["course"],
        content: json["content"],
        body: json["body"],
        fileType: json["file_type"],
        doctype: json["doctype"],
        customLessonVideos: json["custom_lesson_videos"] == null
            ? []
            : List<CustomLessonVideo>.from(json["custom_lesson_videos"]!
                .map((x) => CustomLessonVideo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "docstatus": docstatus,
        "idx": idx,
        "title": title,
        "include_in_preview": includeInPreview,
        "chapter": chapter,
        "is_scorm_package": isScormPackage,
        "course": course,
        "content": content,
        "body": body,
        "file_type": fileType,
        "doctype": doctype,
        "custom_lesson_videos": customLessonVideos == null
            ? []
            : List<dynamic>.from(customLessonVideos!.map((x) => x.toJson())),
      };
}

class CustomLessonVideo {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? type;
  String? videoLink;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  CustomLessonVideo({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.docstatus,
    this.idx,
    this.type,
    this.videoLink,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.doctype,
  });

  factory CustomLessonVideo.fromJson(Map<String, dynamic> json) =>
      CustomLessonVideo(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        docstatus: json["docstatus"],
        idx: json["idx"],
        type: json["type"],
        videoLink: json["video_link"],
        parent: json["parent"],
        parentfield: json["parentfield"],
        parenttype: json["parenttype"],
        doctype: json["doctype"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "docstatus": docstatus,
        "idx": idx,
        "type": type,
        "video_link": videoLink,
        "parent": parent,
        "parentfield": parentfield,
        "parenttype": parenttype,
        "doctype": doctype,
      };
}
