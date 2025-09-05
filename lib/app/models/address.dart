// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'dart:convert';

AddressResponse addressFromJson(String str) =>
    AddressResponse.fromJson(json.decode(str));

String addressToJson(AddressResponse data) => json.encode(data.toJson());

class AddressResponse {
  List<Address>? message;

  AddressResponse({
    this.message,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      AddressResponse(
        message: json["message"] == null
            ? []
            : List<Address>.from(
                json["message"]!.map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class Address {
  String? name;
  String? owner;
  DateTime? creation;
  DateTime? modified;
  String? modifiedBy;
  num? docstatus;
  num? idx;
  String? addressTitle;
  String? addressType;
  String? addressLine1;
  String? addressLine2;
  String? city;
  dynamic county;
  String? state;
  String? country;
  String? pincode;
  String? emailId;
  String? phone;
  dynamic fax;
  dynamic taxCategory;
  num? isPrimaryAddress;
  num? isShippingAddress;
  num? disabled;
  num? isYourCompanyAddress;

  Address({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.docstatus,
    this.idx,
    this.addressTitle,
    this.addressType,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.county,
    this.state,
    this.country,
    this.pincode,
    this.emailId,
    this.phone,
    this.fax,
    this.taxCategory,
    this.isPrimaryAddress,
    this.isShippingAddress,
    this.disabled,
    this.isYourCompanyAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        name: json["name"],
        owner: json["owner"],
        creation:
            json["creation"] == null ? null : DateTime.parse(json["creation"]),
        modified:
            json["modified"] == null ? null : DateTime.parse(json["modified"]),
        modifiedBy: json["modified_by"],
        docstatus: json["docstatus"],
        idx: json["idx"],
        addressTitle: json["address_title"],
        addressType: json["address_type"],
        addressLine1: json["address_line1"],
        addressLine2: json["address_line2"],
        city: json["city"],
        county: json["county"],
        state: json["state"],
        country: json["country"],
        pincode: json["pincode"],
        emailId: json["email_id"],
        phone: json["phone"],
        fax: json["fax"],
        taxCategory: json["tax_category"],
        isPrimaryAddress: json["is_primary_address"],
        isShippingAddress: json["is_shipping_address"],
        disabled: json["disabled"],
        isYourCompanyAddress: json["is_your_company_address"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation?.toIso8601String(),
        "modified": modified?.toIso8601String(),
        "modified_by": modifiedBy,
        "docstatus": docstatus,
        "idx": idx,
        "address_title": addressTitle,
        "address_type": addressType,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "city": city,
        "county": county,
        "state": state,
        "country": country,
        "pincode": pincode,
        "email_id": emailId,
        "phone": phone,
        "fax": fax,
        "tax_category": taxCategory,
        "is_primary_address": isPrimaryAddress,
        "is_shipping_address": isShippingAddress,
        "disabled": disabled,
        "is_your_company_address": isYourCompanyAddress,
      };
}
