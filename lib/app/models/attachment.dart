import 'dart:convert';

AttachmentResponse attachmentResponseFromJson(String str) =>
    AttachmentResponse.fromJson(json.decode(str));

String attachmentResponseToJson(AttachmentResponse data) =>
    json.encode(data.toJson());

class AttachmentResponse {
  List<Attachment>? message;

  AttachmentResponse({
    this.message,
  });

  factory AttachmentResponse.fromJson(Map<String, dynamic> json) =>
      AttachmentResponse(
        message: json["message"] == null
            ? []
            : List<Attachment>.from(
                json["message"]!.map((x) => Attachment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class Attachment {
  String? name;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  String? owner;
  num? docstatus;
  dynamic parent;
  dynamic parentfield;
  dynamic parenttype;
  num? idx;
  String? fileName;
  String? fileUrl;
  dynamic module;
  String? attachedToName;
  num? fileSize;
  String? attachedToDoctype;
  num? isPrivate;
  String? fileType;
  num? isHomeFolder;
  num? isAttachmentsFolder;
  dynamic thumbnailUrl;
  String? folder;
  num? isFolder;
  String? attachedToField;
  dynamic oldParent;
  String? contentHash;
  num? uploadedToDropbox;
  num? uploadedToGoogleDrive;
  dynamic userTags;
  dynamic comments;
  dynamic assign;
  dynamic likedBy;

  Attachment({
    this.name,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.owner,
    this.docstatus,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.idx,
    this.fileName,
    this.fileUrl,
    this.module,
    this.attachedToName,
    this.fileSize,
    this.attachedToDoctype,
    this.isPrivate,
    this.fileType,
    this.isHomeFolder,
    this.isAttachmentsFolder,
    this.thumbnailUrl,
    this.folder,
    this.isFolder,
    this.attachedToField,
    this.oldParent,
    this.contentHash,
    this.uploadedToDropbox,
    this.uploadedToGoogleDrive,
    this.userTags,
    this.comments,
    this.assign,
    this.likedBy,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        name: json["name"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        owner: json["owner"],
        docstatus: json["docstatus"],
        parent: json["parent"],
        parentfield: json["parentfield"],
        parenttype: json["parenttype"],
        idx: json["idx"],
        fileName: json["file_name"],
        fileUrl: json["file_url"],
        module: json["module"],
        attachedToName: json["attached_to_name"],
        fileSize: json["file_size"],
        attachedToDoctype: json["attached_to_doctype"],
        isPrivate: json["is_private"],
        fileType: json["file_type"],
        isHomeFolder: json["is_home_folder"],
        isAttachmentsFolder: json["is_attachments_folder"],
        thumbnailUrl: json["thumbnail_url"],
        folder: json["folder"],
        isFolder: json["is_folder"],
        attachedToField: json["attached_to_field"],
        oldParent: json["old_parent"],
        contentHash: json["content_hash"],
        uploadedToDropbox: json["uploaded_to_dropbox"],
        uploadedToGoogleDrive: json["uploaded_to_google_drive"],
        userTags: json["_user_tags"],
        comments: json["_comments"],
        assign: json["_assign"],
        likedBy: json["_liked_by"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "owner": owner,
        "docstatus": docstatus,
        "parent": parent,
        "parentfield": parentfield,
        "parenttype": parenttype,
        "idx": idx,
        "file_name": fileName,
        "file_url": fileUrl,
        "module": module,
        "attached_to_name": attachedToName,
        "file_size": fileSize,
        "attached_to_doctype": attachedToDoctype,
        "is_private": isPrivate,
        "file_type": fileType,
        "is_home_folder": isHomeFolder,
        "is_attachments_folder": isAttachmentsFolder,
        "thumbnail_url": thumbnailUrl,
        "folder": folder,
        "is_folder": isFolder,
        "attached_to_field": attachedToField,
        "old_parent": oldParent,
        "content_hash": contentHash,
        "uploaded_to_dropbox": uploadedToDropbox,
        "uploaded_to_google_drive": uploadedToGoogleDrive,
        "_user_tags": userTags,
        "_comments": comments,
        "_assign": assign,
        "_liked_by": likedBy,
      };
}
