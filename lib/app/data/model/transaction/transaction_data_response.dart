// To parse this JSON data, do
//
//     final transactionResponse = transactionResponseFromJson(jsonString);

import 'dart:convert';

TransactionResponse transactionResponseFromJson(String str) => TransactionResponse.fromJson(json.decode(str));

String transactionResponseToJson(TransactionResponse data) => json.encode(data.toJson());

class TransactionResponse {
  int? currentPage;
  List<TransactionData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;
  dynamic search;

  TransactionResponse({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
    this.search,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) => TransactionResponse(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<TransactionData>.from(json["data"]!.map((x) => TransactionData.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
    search: json["search"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
    "search": search,
  };
}

class TransactionData {
  int? id;
  String? saleId;
  String? receiveAmount;
  String? transferToCompany;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  Sale? sale;

  TransactionData({
    this.id,
    this.saleId,
    this.receiveAmount,
    this.transferToCompany,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.sale,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) => TransactionData(
    id: json["id"],
    saleId: json["sale_id"],
    receiveAmount: json["receive_amount"],
    transferToCompany: json["transfer_to_company"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    sale: json["sale"] == null ? null : Sale.fromJson(json["sale"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sale_id": saleId,
    "receive_amount": receiveAmount,
    "transfer_to_company": transferToCompany,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "sale": sale?.toJson(),
  };
}

class Sale {
  int? id;
  String? customerId;
  String? paymentMethodId;
  String? saleDate;
  dynamic itemTiers;
  dynamic note;
  String? subTotal;
  String? total;
  String? paidAmount;
  String? amountDue;
  String? commentOnReceipt;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  dynamic branchId;
  String? saleCode;
  dynamic discountEntireSale;
  dynamic discountAllItemByPercent;
  dynamic discountReason;
  dynamic itemTire;
  String? verifyStatus;
  String? verifiedBy;
  String? verifiedAt;
  dynamic suspendedBy;
  dynamic customerName;
  String? suspendRequest;
  dynamic suspendRequestBy;
  String? shippingCost;
  String? deliveryManId;
  String? deliveryStatus;
  dynamic deliveryRejectReason;
  String? deliveredAt;

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

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
