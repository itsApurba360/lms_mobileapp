// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

CourseResponse courseFromJson(String str) =>
    CourseResponse.fromJson(json.decode(str));

String courseToJson(CourseResponse data) => json.encode(data.toJson());

num? _toNum(dynamic value) {
  if (value == null) return null;
  if (value is num) return value;
  if (value is String) {
    final s = value.trim();
    if (s.isEmpty) return null;
    final normalized = s.replaceAll(',', '');
    return num.tryParse(normalized);
  }
  return null;
}

class CourseResponse {
  List<Course>? message;

  CourseResponse({
    this.message,
  });

  factory CourseResponse.fromJson(Map<String, dynamic> json) => CourseResponse(
        message: json["message"] == null
            ? []
            : List<Course>.from(
                json["message"]!.map((x) => Course.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class Course {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  num? docstatus;
  num? idx;
  String? title;
  String? videoLink;
  String? tags;
  String? category;
  String? status;
  String? image;
  String? cardGradient;
  num? customCourseDuration;
  String? customLevel;
  num? published;
  DateTime? publishedOn;
  num? upcoming;
  num? featured;
  num? disableSelfLearning;
  String? shortIntroduction;
  String? description;
  num? paidCourse;
  num? enableCertification;
  num? paidCertificate;
  String? evaluator;
  num? coursePrice;
  num? customDiscount;
  num? customDiscountedPrice;
  String? currency;
  num? amountUsd;
  num? enrollments;
  num? lessons;
  num? rating;
  String? doctype;
  List<dynamic>? relatedCourses;
  List<Chapter>? chapters;
  List<Chapter>? instructors;
  List<CustomCourseResource>? customCourseResources;
  Membership? membership;

  Course({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.docstatus,
    this.idx,
    this.title,
    this.videoLink,
    this.tags,
    this.category,
    this.status,
    this.image,
    this.cardGradient,
    this.customCourseDuration,
    this.customLevel,
    this.published,
    this.publishedOn,
    this.upcoming,
    this.featured,
    this.disableSelfLearning,
    this.shortIntroduction,
    this.description,
    this.paidCourse,
    this.enableCertification,
    this.paidCertificate,
    this.evaluator,
    this.coursePrice,
    this.customDiscount,
    this.customDiscountedPrice,
    this.currency,
    this.amountUsd,
    this.enrollments,
    this.lessons,
    this.rating,
    this.doctype,
    this.relatedCourses,
    this.chapters,
    this.instructors,
    this.customCourseResources,
    this.membership,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
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
        videoLink: json["video_link"],
        tags: json["tags"],
        category: json["category"],
        status: json["status"],
        image: json["image"],
        cardGradient: json["card_gradient"],
        customCourseDuration: json["custom_course_duration"],
        customLevel: json["custom_level"],
        published: json["published"],
        publishedOn: json["published_on"] == null
            ? null
            : DateTime.parse(json["published_on"]),
        upcoming: json["upcoming"],
        featured: json["featured"],
        disableSelfLearning: json["disable_self_learning"],
        shortIntroduction: json["short_introduction"],
        description: json["description"],
        paidCourse: json["paid_course"],
        enableCertification: json["enable_certification"],
        paidCertificate: json["paid_certificate"],
        evaluator: json["evaluator"],
        coursePrice: json["course_price"],
        customDiscount: json["custom_discount"],
        customDiscountedPrice: json["custom_discounted_price"],
        currency: json["currency"],
        amountUsd: json["amount_usd"],
        enrollments: json["enrollments"],
        lessons: json["lessons"],
        rating: _toNum(json["rating"]),
        doctype: json["doctype"],
        relatedCourses: json["related_courses"] == null
            ? []
            : List<dynamic>.from(json["related_courses"]!.map((x) => x)),
        chapters: json["chapters"] == null
            ? []
            : List<Chapter>.from(
                json["chapters"]!.map((x) => Chapter.fromJson(x))),
        instructors: json["instructors"] == null
            ? []
            : List<Chapter>.from(
                json["instructors"]!.map((x) => Chapter.fromJson(x))),
        customCourseResources: json["custom_course_resources"] == null
            ? []
            : List<CustomCourseResource>.from(json["custom_course_resources"]!
                .map((x) => CustomCourseResource.fromJson(x))),
        membership: json["membership"] == null
            ? null
            : Membership.fromJson(json["membership"]),
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
        "video_link": videoLink,
        "tags": tags,
        "category": category,
        "status": status,
        "image": image,
        "card_gradient": cardGradient,
        "custom_course_duration": customCourseDuration,
        "custom_level": customLevel,
        "published": published,
        "published_on":
            "${publishedOn!.year.toString().padLeft(4, '0')}-${publishedOn!.month.toString().padLeft(2, '0')}-${publishedOn!.day.toString().padLeft(2, '0')}",
        "upcoming": upcoming,
        "featured": featured,
        "disable_self_learning": disableSelfLearning,
        "short_introduction": shortIntroduction,
        "description": description,
        "paid_course": paidCourse,
        "enable_certification": enableCertification,
        "paid_certificate": paidCertificate,
        "evaluator": evaluator,
        "course_price": coursePrice,
        "custom_discount": customDiscount,
        "custom_discounted_price": customDiscountedPrice,
        "currency": currency,
        "amount_usd": amountUsd,
        "enrollments": enrollments,
        "lessons": lessons,
        "rating": rating,
        "doctype": doctype,
        "related_courses": relatedCourses == null
            ? []
            : List<dynamic>.from(relatedCourses!.map((x) => x)),
        "chapters": chapters == null
            ? []
            : List<dynamic>.from(chapters!.map((x) => x.toJson())),
        "instructors": instructors == null
            ? []
            : List<dynamic>.from(instructors!.map((x) => x.toJson())),
        "custom_course_resources": customCourseResources == null
            ? []
            : List<dynamic>.from(customCourseResources!.map((x) => x.toJson())),
        "membership": membership?.toJson(),
      };
}

class Chapter {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  num? docstatus;
  num? idx;
  String? chapter;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;
  String? instructor;

  Chapter({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.docstatus,
    this.idx,
    this.chapter,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.doctype,
    this.instructor,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        docstatus: json["docstatus"],
        idx: json["idx"],
        chapter: json["chapter"],
        parent: json["parent"],
        parentfield: json["parentfield"],
        parenttype: json["parenttype"],
        doctype: json["doctype"],
        instructor: json["instructor"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "docstatus": docstatus,
        "idx": idx,
        "chapter": chapter,
        "parent": parent,
        "parentfield": parentfield,
        "parenttype": parenttype,
        "doctype": doctype,
        "instructor": instructor,
      };
}

class CustomCourseResource {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  num? docstatus;
  num? idx;
  String? title;
  String? type;
  String? attachment;
  num? includeInPreview;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  CustomCourseResource({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.docstatus,
    this.idx,
    this.title,
    this.type,
    this.attachment,
    this.includeInPreview,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.doctype,
  });

  factory CustomCourseResource.fromJson(Map<String, dynamic> json) =>
      CustomCourseResource(
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
        type: json["type"],
        attachment: json["attachment"],
        includeInPreview: json["include_in_preview"],
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
        "title": title,
        "type": type,
        "attachment": attachment,
        "include_in_preview": includeInPreview,
        "parent": parent,
        "parentfield": parentfield,
        "parenttype": parenttype,
        "doctype": doctype,
      };
}

class Membership {
  String? name;
  String? course;
  dynamic currentLesson;
  num? progress;
  String? member;

  Membership({
    this.name,
    this.course,
    this.currentLesson,
    this.progress,
    this.member,
  });

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        name: json["name"],
        course: json["course"],
        currentLesson: json["current_lesson"],
        progress: json["progress"],
        member: json["member"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "course": course,
        "current_lesson": currentLesson,
        "progress": progress,
        "member": member,
      };
}
