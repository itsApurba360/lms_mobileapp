// To parse this JSON data, do
//
//     final courseOutline = courseOutlineFromJson(jsonString);

import 'dart:convert';

CourseOutlineResponse courseOutlineFromJson(String str) =>
    CourseOutlineResponse.fromJson(json.decode(str));

String courseOutlineToJson(CourseOutlineResponse data) =>
    json.encode(data.toJson());

class CourseOutlineResponse {
  List<CourseOutline>? message;

  CourseOutlineResponse({
    this.message,
  });

  factory CourseOutlineResponse.fromJson(Map<String, dynamic> json) =>
      CourseOutlineResponse(
        message: json["message"] == null
            ? []
            : List<CourseOutline>.from(
                json["message"]!.map((x) => CourseOutline.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class CourseOutline {
  String? name;
  String? title;
  int? isScormPackage;
  dynamic launchFile;
  dynamic scormPackage;
  int? idx;
  List<Lesson>? lessons;

  CourseOutline({
    this.name,
    this.title,
    this.isScormPackage,
    this.launchFile,
    this.scormPackage,
    this.idx,
    this.lessons,
  });

  factory CourseOutline.fromJson(Map<String, dynamic> json) => CourseOutline(
        name: json["name"],
        title: json["title"],
        isScormPackage: json["is_scorm_package"],
        launchFile: json["launch_file"],
        scormPackage: json["scorm_package"],
        idx: json["idx"],
        lessons: json["lessons"] == null
            ? []
            : List<Lesson>.from(
                json["lessons"]!.map((x) => Lesson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "is_scorm_package": isScormPackage,
        "launch_file": launchFile,
        "scorm_package": scormPackage,
        "idx": idx,
        "lessons": lessons == null
            ? []
            : List<dynamic>.from(lessons!.map((x) => x.toJson())),
      };
}

class Lesson {
  String? name;
  String? title;
  int? includeInPreview;
  dynamic body;
  DateTime? creation;
  dynamic youtube;
  dynamic quizId;
  dynamic question;
  String? fileType;
  dynamic instructorNotes;
  String? course;
  dynamic content;
  String? number;
  String? icon;

  Lesson({
    this.name,
    this.title,
    this.includeInPreview,
    this.body,
    this.creation,
    this.youtube,
    this.quizId,
    this.question,
    this.fileType,
    this.instructorNotes,
    this.course,
    this.content,
    this.number,
    this.icon,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        name: json["name"],
        title: json["title"],
        includeInPreview: json["include_in_preview"],
        body: json["body"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        youtube: json["youtube"],
        quizId: json["quiz_id"],
        question: json["question"],
        fileType: json["file_type"],
        instructorNotes: json["instructor_notes"],
        course: json["course"],
        content: json["content"],
        number: json["number"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "include_in_preview": includeInPreview,
        "body": body,
        "creation": creation?.toIso8601String(),
        "youtube": youtube,
        "quiz_id": quizId,
        "question": question,
        "file_type": fileType,
        "instructor_notes": instructorNotes,
        "course": course,
        "content": content,
        "number": number,
        "icon": icon,
      };
}
