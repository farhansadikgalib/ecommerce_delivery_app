import 'dart:convert';

OrderStatusResponse orderStatusResponseFromJson(String str) => OrderStatusResponse.fromJson(json.decode(str));

String orderStatusResponseToJson(OrderStatusResponse data) => json.encode(data.toJson());

class OrderStatusResponse {
  String? status;
  String? message;
  Sale? sale;

  OrderStatusResponse({
    this.status,
    this.message,
    this.sale,
  });

  factory OrderStatusResponse.fromJson(Map<String, dynamic> json) => OrderStatusResponse(
    status: json["status"],
    message: json["message"],
    sale: json["sale"] == null ? null : Sale.fromJson(json["sale"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "sale": sale?.toJson(),
  };
}

class Sale {
  int? id;
  dynamic customerId;
  String? paymentMethodId;
  String? saleDate;
  dynamic itemTiers;
  dynamic note;
  String? subTotal;
  String? total;
  String? paidAmount;
  String? amountDue;
  String? commentOnReceipt;
  dynamic createdBy;
  String? createdAt;
  String? updatedAt;
  dynamic branchId;
  String? saleCode;
  dynamic discountEntireSale;
  dynamic discountAllItemByPercent;
  dynamic discountReason;
  dynamic itemTire;
  String? verifyStatus;
  dynamic verifiedBy;
  dynamic verifiedAt;
  dynamic suspendedBy;
  dynamic customerName;
  String? suspendRequest;
  dynamic suspendRequestBy;
  dynamic shippingCost;
  String? deliveryManId;
  String? deliveryStatus;
  dynamic deliveryRejectReason;
  dynamic deliveredAt;

  Sale({
    this.id,
    this.customerId,
    this.paymentMethodId,
    this.saleDate,
    this.itemTiers,
    this.note,
    this.subTotal,
    this.total,
    this.paidAmount,
    this.amountDue,
    this.commentOnReceipt,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.branchId,
    this.saleCode,
    this.discountEntireSale,
    this.discountAllItemByPercent,
    this.discountReason,
    this.itemTire,
    this.verifyStatus,
    this.verifiedBy,
    this.verifiedAt,
    this.suspendedBy,
    this.customerName,
    this.suspendRequest,
    this.suspendRequestBy,
    this.shippingCost,
    this.deliveryManId,
    this.deliveryStatus,
    this.deliveryRejectReason,
    this.deliveredAt,
  });

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
    id: json["id"],
    customerId: json["customer_id"],
    paymentMethodId: json["payment_method_id"],
    saleDate: json["sale_date"],
    itemTiers: json["item_tiers"],
    note: json["note"],
    subTotal: json["sub_total"],
    total: json["total"],
    paidAmount: json["paid_amount"],
    amountDue: json["amount_due"],
    commentOnReceipt: json["comment_on_receipt"],
    createdBy: json["created_by"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    branchId: json["branch_id"],
    saleCode: json["sale_code"],
    discountEntireSale: json["discount_entire_sale"],
    discountAllItemByPercent: json["discount_all_item_by_percent"],
    discountReason: json["discount_reason"],
    itemTire: json["item_tire"],
    verifyStatus: json["verify_status"],
    verifiedBy: json["verified_by"],
    verifiedAt: json["verified_at"],
    suspendedBy: json["suspended_by"],
    customerName: json["customer_name"],
    suspendRequest: json["suspend_request"],
    suspendRequestBy: json["suspend_request_by"],
    shippingCost: json["shipping_cost"],
    deliveryManId: json["delivery_man_id"],
    deliveryStatus: json["delivery_status"],
    deliveryRejectReason: json["delivery_reject_reason"],
    deliveredAt: json["delivered_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "payment_method_id": paymentMethodId,
    "sale_date": saleDate,
    "item_tiers": itemTiers,
    "note": note,
    "sub_total": subTotal,
    "total": total,
    "paid_amount": paidAmount,
    "amount_due": amountDue,
    "comment_on_receipt": commentOnReceipt,
    "created_by": createdBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "branch_id": branchId,
    "sale_code": saleCode,
    "discount_entire_sale": discountEntireSale,
    "discount_all_item_by_percent": discountAllItemByPercent,
    "discount_reason": discountReason,
    "item_tire": itemTire,
    "verify_status": verifyStatus,
    "verified_by": verifiedBy,
    "verified_at": verifiedAt,
    "suspended_by": suspendedBy,
    "customer_name": customerName,
    "suspend_request": suspendRequest,
    "suspend_request_by": suspendRequestBy,
    "shipping_cost": shippingCost,
    "delivery_man_id": deliveryManId,
    "delivery_status": deliveryStatus,
    "delivery_reject_reason": deliveryRejectReason,
    "delivered_at": deliveredAt,
  };
}
