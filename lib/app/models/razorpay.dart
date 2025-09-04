import 'dart:convert';

RazorpayResponse razorpayFromJson(String str) =>
    RazorpayResponse.fromJson(json.decode(str));

String razorpayToJson(RazorpayResponse data) => json.encode(data.toJson());

class RazorpayResponse {
  RazorpayModel? message;

  RazorpayResponse({
    this.message,
  });

  factory RazorpayResponse.fromJson(Map<String, dynamic> json) =>
      RazorpayResponse(
        message: json["message"] == null
            ? null
            : RazorpayModel.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message?.toJson(),
      };
}

class RazorpayModel {
  int? amount;
  String? title;
  String? description;
  String? referenceDoctype;
  String? referenceDocname;
  String? payerEmail;
  String? payerName;
  String? currency;
  String? paymentGateway;
  dynamic redirectTo;
  String? payment;
  String? orderId;
  String? integrationRequest;
  String? razorpayKey;

  RazorpayModel({
    this.amount,
    this.title,
    this.description,
    this.referenceDoctype,
    this.referenceDocname,
    this.payerEmail,
    this.payerName,
    this.currency,
    this.paymentGateway,
    this.redirectTo,
    this.payment,
    this.orderId,
    this.integrationRequest,
    this.razorpayKey,
  });

  factory RazorpayModel.fromJson(Map<String, dynamic> json) => RazorpayModel(
        amount: json["amount"],
        title: json["title"],
        description: json["description"],
        referenceDoctype: json["reference_doctype"],
        referenceDocname: json["reference_docname"],
        payerEmail: json["payer_email"],
        payerName: json["payer_name"],
        currency: json["currency"],
        paymentGateway: json["payment_gateway"],
        redirectTo: json["redirect_to"],
        payment: json["payment"],
        orderId: json["order_id"],
        integrationRequest: json["integration_request"],
        razorpayKey: json["razorpay_key"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "title": title,
        "description": description,
        "reference_doctype": referenceDoctype,
        "reference_docname": referenceDocname,
        "payer_email": payerEmail,
        "payer_name": payerName,
        "currency": currency,
        "payment_gateway": paymentGateway,
        "redirect_to": redirectTo,
        "payment": payment,
        "order_id": orderId,
        "integration_request": integrationRequest,
        "razorpay_key": razorpayKey,
      };
}
