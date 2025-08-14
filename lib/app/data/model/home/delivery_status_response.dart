import 'dart:convert';

DeliveryStatusResponse deliveryStatusResponseFromJson(String str) => DeliveryStatusResponse.fromJson(json.decode(str));

String deliveryStatusResponseToJson(DeliveryStatusResponse data) => json.encode(data.toJson());

class DeliveryStatusResponse {
  String? status;
  String? message;
  DeliveryMan? deliveryMan;

  DeliveryStatusResponse({
    this.status,
    this.message,
    this.deliveryMan,
  });

  factory DeliveryStatusResponse.fromJson(Map<String, dynamic> json) => DeliveryStatusResponse(
    status: json["status"],
    message: json["message"],
    deliveryMan: json["delivery_man"] == null ? null : DeliveryMan.fromJson(json["delivery_man"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "delivery_man": deliveryMan?.toJson(),
  };
}

class DeliveryMan {
  int? id;
  String? userId;
  String? status;
  dynamic createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic createdBy;
  int? updatedBy;
  dynamic deletedBy;

  DeliveryMan({
    this.id,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
  });

  factory DeliveryMan.fromJson(Map<String, dynamic> json) => DeliveryMan(
    id: json["id"],
    userId: json["user_id"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
  };
}
