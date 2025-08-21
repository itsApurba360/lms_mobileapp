// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

CourseResponse courseFromJson(String str) =>
    CourseResponse.fromJson(json.decode(str));

String courseToJson(CourseResponse data) => json.encode(data.toJson());

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
        rating: json["rating"] == null
            ? null
            : (json["rating"] is String
                ? (double.tryParse(json["rating"])?.round())
                : (json["rating"] as num?)?.round()),
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
      };
}
