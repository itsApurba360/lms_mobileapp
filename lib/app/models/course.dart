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
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  String? owner;
  num? docstatus;
  num? idx;
  String? title;
  String? videoLink;
  String? tags;
  String? category;
  String? status;
  String? image;
  String? cardGradient;
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
  String? currency;
  num? amountUsd;
  num? enrollments;
  num? lessons;
  num? rating;
  dynamic userTags;
  dynamic comments;
  dynamic assign;
  dynamic likedBy;
  num? customCourseDuration;
  String? customLevel;
  num? customDiscount;
  num? customDiscountedPrice;
  Membership? membership;
  List<Instructor>? instructors;
  num? amount;
  String? price;

  Course({
    this.name,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.owner,
    this.docstatus,
    this.idx,
    this.title,
    this.videoLink,
    this.tags,
    this.category,
    this.status,
    this.image,
    this.cardGradient,
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
    this.currency,
    this.amountUsd,
    this.enrollments,
    this.lessons,
    this.rating,
    this.userTags,
    this.comments,
    this.assign,
    this.likedBy,
    this.customCourseDuration,
    this.customLevel,
    this.customDiscount,
    this.customDiscountedPrice,
    this.membership,
    this.instructors,
    this.amount,
    this.price,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        name: json["name"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        owner: json["owner"],
        docstatus: json["docstatus"],
        idx: json["idx"],
        title: json["title"],
        videoLink: json["video_link"],
        tags: json["tags"],
        category: json["category"],
        status: json["status"],
        image: json["image"],
        cardGradient: json["card_gradient"],
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
        currency: json["currency"],
        amountUsd: json["amount_usd"],
        enrollments: json["enrollments"],
        lessons: json["lessons"],
        rating: json["rating"],
        userTags: json["_user_tags"],
        comments: json["_comments"],
        assign: json["_assign"],
        likedBy: json["_liked_by"],
        customCourseDuration: json["custom_course_duration"],
        customLevel: json["custom_level"],
        customDiscount: json["custom_discount"],
        customDiscountedPrice: json["custom_discounted_price"],
        membership: json["membership"] == null
            ? null
            : Membership.fromJson(json["membership"]),
        instructors: json["instructors"] == null
            ? []
            : List<Instructor>.from(
                json["instructors"]!.map((x) => Instructor.fromJson(x))),
        amount: json["amount"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "owner": owner,
        "docstatus": docstatus,
        "idx": idx,
        "title": title,
        "video_link": videoLink,
        "tags": tags,
        "category": category,
        "status": status,
        "image": image,
        "card_gradient": cardGradient,
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
        "currency": currency,
        "amount_usd": amountUsd,
        "enrollments": enrollments,
        "lessons": lessons,
        "rating": rating,
        "_user_tags": userTags,
        "_comments": comments,
        "_assign": assign,
        "_liked_by": likedBy,
        "custom_course_duration": customCourseDuration,
        "custom_level": customLevel,
        "custom_discount": customDiscount,
        "custom_discounted_price": customDiscountedPrice,
        "membership": membership?.toJson(),
        "instructors": instructors == null
            ? []
            : List<dynamic>.from(instructors!.map((x) => x.toJson())),
        "amount": amount,
        "price": price,
      };
}

class Instructor {
  String? name;
  String? username;
  String? fullName;
  dynamic userImage;
  String? firstName;

  Instructor({
    this.name,
    this.username,
    this.fullName,
    this.userImage,
    this.firstName,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        name: json["name"],
        username: json["username"],
        fullName: json["full_name"],
        userImage: json["user_image"],
        firstName: json["first_name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "full_name": fullName,
        "user_image": userImage,
        "first_name": firstName,
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
