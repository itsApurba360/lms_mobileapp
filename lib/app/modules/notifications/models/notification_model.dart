class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime date;
  final bool isRead;
  final String? type;
  final Map<String, dynamic>? data;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    this.isRead = false,
    this.type,
    this.data,
  });

  // Convert a NotificationModel to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'date': date.toIso8601String(),
      'isRead': isRead,
      'type': type,
      'data': data,
    };
  }

  // Create a NotificationModel from a Map
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      isRead: json['isRead'] ?? false,
      type: json['type'],
      data: json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
    );
  }

  // Create a copy of the notification with some updated values
  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? date,
    bool? isRead,
    String? type,
    Map<String, dynamic>? data,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      date: date ?? this.date,
      isRead: isRead ?? this.isRead,
      type: type ?? this.type,
      data: data ?? this.data,
    );
  }
}
