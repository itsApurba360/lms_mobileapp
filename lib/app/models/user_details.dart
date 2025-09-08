// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

UserDetailsResponse userDetailsFromJson(String str) =>
    UserDetailsResponse.fromJson(json.decode(str));

String userDetailsToJson(UserDetailsResponse data) =>
    json.encode(data.toJson());

class UserDetailsResponse {
  UserDetails? message;

  UserDetailsResponse({
    this.message,
  });

  factory UserDetailsResponse.fromJson(Map<String, dynamic> json) =>
      UserDetailsResponse(
        message: json["message"] == null
            ? null
            : UserDetails.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class UserDetails {
  User? user;
  Student? student;
  List<MessageRole>? roles;

  UserDetails({
    this.user,
    this.student,
    this.roles,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        student:
            json["student"] == null ? null : Student.fromJson(json["student"]),
        roles: json["roles"] == null
            ? []
            : List<MessageRole>.from(
                json["roles"]!.map((x) => MessageRole.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "student": student?.toJson(),
        "roles": roles == null
            ? []
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
      };
}

class MessageRole {
  String? role;

  MessageRole({
    this.role,
  });

  factory MessageRole.fromJson(Map<String, dynamic> json) => MessageRole(
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
      };
}

class Student {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  num? docstatus;
  num? idx;
  String? studentName;
  String? email;
  String? mobileNo;
  String? status;
  String? gender;
  String? user;
  String? doctype;

  Student({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.docstatus,
    this.idx,
    this.studentName,
    this.email,
    this.mobileNo,
    this.status,
    this.gender,
    this.user,
    this.doctype,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        docstatus: json["docstatus"],
        idx: json["idx"],
        studentName: json["student_name"],
        email: json["email"],
        mobileNo: json["mobile_no"],
        status: json["status"],
        gender: json["gender"],
        user: json["user"],
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
        "student_name": studentName,
        "email": email,
        "mobile_no": mobileNo,
        "status": status,
        "gender": gender,
        "user": user,
        "doctype": doctype,
      };
}

class User {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  num? docstatus;
  num? idx;
  num? enabled;
  String? email;
  String? firstName;
  String? lastName;
  String? fullName;
  String? username;
  String? country;
  num? verifyTerms;
  String? language;
  String? timeZone;
  String? userCategory;
  num? sendWelcomeEmail;
  num? unsubscribed;
  num? lookingForJob;
  String? mobileNo;
  num? hidePrivate;
  String? attire;
  String? collaboration;
  String? role;
  String? locationPreference;
  String? time;
  String? companyType;
  num? muteSounds;
  String? deskTheme;
  num? searchBar;
  num? notifications;
  num? listSidebar;
  num? bulkActions;
  num? viewSwitcher;
  num? formSidebar;
  num? timeline;
  num? dashboard;
  String? newPassword;
  num? logoutAllSessions;
  num? documentFollowNotify;
  String? documentFollowFrequency;
  num? followCreatedDocuments;
  num? followCommentedDocuments;
  num? followLikedDocuments;
  num? followAssignedDocuments;
  num? followSharedDocuments;
  num? threadNotify;
  num? sendMeACopy;
  num? allowedInMentions;
  num? simultaneousSessions;
  String? lastIp;
  num? loginAfter;
  String? userType;
  DateTime? lastActive;
  num? loginBefore;
  num? bypassRestrictIpCheckIf2FaEnabled;
  DateTime? lastLogin;
  String? onboardingStatus;
  String? doctype;
  List<SocialLoginElement>? roles;
  List<dynamic>? blockModules;
  List<dynamic>? preferredFunctions;
  List<dynamic>? defaults;
  List<dynamic>? userEmails;
  List<dynamic>? skill;
  List<dynamic>? certification;
  List<dynamic>? internship;
  List<dynamic>? workExperience;
  List<dynamic>? preferredIndustries;
  List<dynamic>? education;
  List<SocialLoginElement>? socialLogins;

  User({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.docstatus,
    this.idx,
    this.enabled,
    this.email,
    this.firstName,
    this.lastName,
    this.fullName,
    this.username,
    this.country,
    this.verifyTerms,
    this.language,
    this.timeZone,
    this.userCategory,
    this.sendWelcomeEmail,
    this.unsubscribed,
    this.lookingForJob,
    this.mobileNo,
    this.hidePrivate,
    this.attire,
    this.collaboration,
    this.role,
    this.locationPreference,
    this.time,
    this.companyType,
    this.muteSounds,
    this.deskTheme,
    this.searchBar,
    this.notifications,
    this.listSidebar,
    this.bulkActions,
    this.viewSwitcher,
    this.formSidebar,
    this.timeline,
    this.dashboard,
    this.newPassword,
    this.logoutAllSessions,
    this.documentFollowNotify,
    this.documentFollowFrequency,
    this.followCreatedDocuments,
    this.followCommentedDocuments,
    this.followLikedDocuments,
    this.followAssignedDocuments,
    this.followSharedDocuments,
    this.threadNotify,
    this.sendMeACopy,
    this.allowedInMentions,
    this.simultaneousSessions,
    this.lastIp,
    this.loginAfter,
    this.userType,
    this.lastActive,
    this.loginBefore,
    this.bypassRestrictIpCheckIf2FaEnabled,
    this.lastLogin,
    this.onboardingStatus,
    this.doctype,
    this.roles,
    this.blockModules,
    this.preferredFunctions,
    this.defaults,
    this.userEmails,
    this.skill,
    this.certification,
    this.internship,
    this.workExperience,
    this.preferredIndustries,
    this.education,
    this.socialLogins,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        docstatus: json["docstatus"],
        idx: json["idx"],
        enabled: json["enabled"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        fullName: json["full_name"],
        username: json["username"],
        country: json["country"],
        verifyTerms: json["verify_terms"],
        language: json["language"],
        timeZone: json["time_zone"],
        userCategory: json["user_category"],
        sendWelcomeEmail: json["send_welcome_email"],
        unsubscribed: json["unsubscribed"],
        lookingForJob: json["looking_for_job"],
        mobileNo: json["mobile_no"],
        hidePrivate: json["hide_private"],
        attire: json["attire"],
        collaboration: json["collaboration"],
        role: json["role"],
        locationPreference: json["location_preference"],
        time: json["time"],
        companyType: json["company_type"],
        muteSounds: json["mute_sounds"],
        deskTheme: json["desk_theme"],
        searchBar: json["search_bar"],
        notifications: json["notifications"],
        listSidebar: json["list_sidebar"],
        bulkActions: json["bulk_actions"],
        viewSwitcher: json["view_switcher"],
        formSidebar: json["form_sidebar"],
        timeline: json["timeline"],
        dashboard: json["dashboard"],
        newPassword: json["new_password"],
        logoutAllSessions: json["logout_all_sessions"],
        documentFollowNotify: json["document_follow_notify"],
        documentFollowFrequency: json["document_follow_frequency"],
        followCreatedDocuments: json["follow_created_documents"],
        followCommentedDocuments: json["follow_commented_documents"],
        followLikedDocuments: json["follow_liked_documents"],
        followAssignedDocuments: json["follow_assigned_documents"],
        followSharedDocuments: json["follow_shared_documents"],
        threadNotify: json["thread_notify"],
        sendMeACopy: json["send_me_a_copy"],
        allowedInMentions: json["allowed_in_mentions"],
        simultaneousSessions: json["simultaneous_sessions"],
        lastIp: json["last_ip"],
        loginAfter: json["login_after"],
        userType: json["user_type"],
        lastActive: json["last_active"] == null
            ? null
            : DateTime.parse(json["last_active"]),
        loginBefore: json["login_before"],
        bypassRestrictIpCheckIf2FaEnabled:
            json["bypass_restrict_ip_check_if_2fa_enabled"],
        lastLogin: json["last_login"] == null
            ? null
            : DateTime.parse(json["last_login"]),
        onboardingStatus: json["onboarding_status"],
        doctype: json["doctype"],
        roles: json["roles"] == null
            ? []
            : List<SocialLoginElement>.from(
                json["roles"]!.map((x) => SocialLoginElement.fromJson(x))),
        blockModules: json["block_modules"] == null
            ? []
            : List<dynamic>.from(json["block_modules"]!.map((x) => x)),
        preferredFunctions: json["preferred_functions"] == null
            ? []
            : List<dynamic>.from(json["preferred_functions"]!.map((x) => x)),
        defaults: json["defaults"] == null
            ? []
            : List<dynamic>.from(json["defaults"]!.map((x) => x)),
        userEmails: json["user_emails"] == null
            ? []
            : List<dynamic>.from(json["user_emails"]!.map((x) => x)),
        skill: json["skill"] == null
            ? []
            : List<dynamic>.from(json["skill"]!.map((x) => x)),
        certification: json["certification"] == null
            ? []
            : List<dynamic>.from(json["certification"]!.map((x) => x)),
        internship: json["internship"] == null
            ? []
            : List<dynamic>.from(json["internship"]!.map((x) => x)),
        workExperience: json["work_experience"] == null
            ? []
            : List<dynamic>.from(json["work_experience"]!.map((x) => x)),
        preferredIndustries: json["preferred_industries"] == null
            ? []
            : List<dynamic>.from(json["preferred_industries"]!.map((x) => x)),
        education: json["education"] == null
            ? []
            : List<dynamic>.from(json["education"]!.map((x) => x)),
        socialLogins: json["social_logins"] == null
            ? []
            : List<SocialLoginElement>.from(json["social_logins"]!
                .map((x) => SocialLoginElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "docstatus": docstatus,
        "idx": idx,
        "enabled": enabled,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "full_name": fullName,
        "username": username,
        "country": country,
        "verify_terms": verifyTerms,
        "language": language,
        "time_zone": timeZone,
        "user_category": userCategory,
        "send_welcome_email": sendWelcomeEmail,
        "unsubscribed": unsubscribed,
        "looking_for_job": lookingForJob,
        "mobile_no": mobileNo,
        "hide_private": hidePrivate,
        "attire": attire,
        "collaboration": collaboration,
        "role": role,
        "location_preference": locationPreference,
        "time": time,
        "company_type": companyType,
        "mute_sounds": muteSounds,
        "desk_theme": deskTheme,
        "search_bar": searchBar,
        "notifications": notifications,
        "list_sidebar": listSidebar,
        "bulk_actions": bulkActions,
        "view_switcher": viewSwitcher,
        "form_sidebar": formSidebar,
        "timeline": timeline,
        "dashboard": dashboard,
        "new_password": newPassword,
        "logout_all_sessions": logoutAllSessions,
        "document_follow_notify": documentFollowNotify,
        "document_follow_frequency": documentFollowFrequency,
        "follow_created_documents": followCreatedDocuments,
        "follow_commented_documents": followCommentedDocuments,
        "follow_liked_documents": followLikedDocuments,
        "follow_assigned_documents": followAssignedDocuments,
        "follow_shared_documents": followSharedDocuments,
        "thread_notify": threadNotify,
        "send_me_a_copy": sendMeACopy,
        "allowed_in_mentions": allowedInMentions,
        "simultaneous_sessions": simultaneousSessions,
        "last_ip": lastIp,
        "login_after": loginAfter,
        "user_type": userType,
        "last_active": lastActive?.toIso8601String(),
        "login_before": loginBefore,
        "bypass_restrict_ip_check_if_2fa_enabled":
            bypassRestrictIpCheckIf2FaEnabled,
        "last_login": lastLogin?.toIso8601String(),
        "onboarding_status": onboardingStatus,
        "doctype": doctype,
        "roles": roles == null
            ? []
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
        "block_modules": blockModules == null
            ? []
            : List<dynamic>.from(blockModules!.map((x) => x)),
        "preferred_functions": preferredFunctions == null
            ? []
            : List<dynamic>.from(preferredFunctions!.map((x) => x)),
        "defaults":
            defaults == null ? [] : List<dynamic>.from(defaults!.map((x) => x)),
        "user_emails": userEmails == null
            ? []
            : List<dynamic>.from(userEmails!.map((x) => x)),
        "skill": skill == null ? [] : List<dynamic>.from(skill!.map((x) => x)),
        "certification": certification == null
            ? []
            : List<dynamic>.from(certification!.map((x) => x)),
        "internship": internship == null
            ? []
            : List<dynamic>.from(internship!.map((x) => x)),
        "work_experience": workExperience == null
            ? []
            : List<dynamic>.from(workExperience!.map((x) => x)),
        "preferred_industries": preferredIndustries == null
            ? []
            : List<dynamic>.from(preferredIndustries!.map((x) => x)),
        "education": education == null
            ? []
            : List<dynamic>.from(education!.map((x) => x)),
        "social_logins": socialLogins == null
            ? []
            : List<dynamic>.from(socialLogins!.map((x) => x.toJson())),
      };
}

class SocialLoginElement {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  num? docstatus;
  num? idx;
  String? role;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;
  String? provider;
  String? userid;

  SocialLoginElement({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.docstatus,
    this.idx,
    this.role,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.doctype,
    this.provider,
    this.userid,
  });

  factory SocialLoginElement.fromJson(Map<String, dynamic> json) =>
      SocialLoginElement(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        docstatus: json["docstatus"],
        idx: json["idx"],
        role: json["role"],
        parent: json["parent"],
        parentfield: json["parentfield"],
        parenttype: json["parenttype"],
        doctype: json["doctype"],
        provider: json["provider"],
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "docstatus": docstatus,
        "idx": idx,
        "role": role,
        "parent": parent,
        "parentfield": parentfield,
        "parenttype": parenttype,
        "doctype": doctype,
        "provider": provider,
        "userid": userid,
      };
}
