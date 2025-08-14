import 'dart:convert';

DelieveryOrderResponse delieveryOrderResponseFromJson(String str) => DelieveryOrderResponse.fromJson(json.decode(str));

String delieveryOrderResponseToJson(DelieveryOrderResponse data) => json.encode(data.toJson());

class DelieveryOrderResponse {
  int? currentPage;
  List<OrderData>? data;
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

  DelieveryOrderResponse({
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

  factory DelieveryOrderResponse.fromJson(Map<String, dynamic> json) => DelieveryOrderResponse(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<OrderData>.from(json["data"]!.map((x) => OrderData.fromJson(x))),
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

class OrderData {
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
  List<SaleProduct>? saleProducts;
  PaymentMethod? paymentMethod;
  dynamic soldUser;
  dynamic customer;
  BillingAddress? billingAddress;

  OrderData({
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
    this.saleProducts,
    this.paymentMethod,
    this.soldUser,
    this.customer,
    this.billingAddress,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
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
    saleProducts: json["sale_products"] == null ? [] : List<SaleProduct>.from(json["sale_products"]!.map((x) => SaleProduct.fromJson(x))),
    paymentMethod: json["payment_method"] == null ? null : PaymentMethod.fromJson(json["payment_method"]),
    soldUser: json["sold_user"],
    customer: json["customer"],
    billingAddress: json["billing_address"] == null ? null : BillingAddress.fromJson(json["billing_address"]),
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
    "sale_products": saleProducts == null ? [] : List<dynamic>.from(saleProducts!.map((x) => x.toJson())),
    "payment_method": paymentMethod?.toJson(),
    "sold_user": soldUser,
    "customer": customer,
    "billing_address": billingAddress?.toJson(),
  };
}

class BillingAddress {
  int? id;
  String? saleId;
  String? fullName;
  String? mobile;
  String? address;
  dynamic countryId;
  String? cityId;
  dynamic notes;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  BillingAddress({
    this.id,
    this.saleId,
    this.fullName,
    this.mobile,
    this.address,
    this.countryId,
    this.cityId,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> json) => BillingAddress(
    id: json["id"],
    saleId: json["sale_id"],
    fullName: json["full_name"],
    mobile: json["mobile"],
    address: json["address"],
    countryId: json["country_id"],
    cityId: json["city_id"],
    notes: json["notes"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sale_id": saleId,
    "full_name": fullName,
    "mobile": mobile,
    "address": address,
    "country_id": countryId,
    "city_id": cityId,
    "notes": notes,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}

class PaymentMethod {
  int? id;
  String? name;
  String? slug;
  String? code;
  String? note;
  String? status;
  dynamic createdAt;
  dynamic updatedAt;

  PaymentMethod({
    this.id,
    this.name,
    this.slug,
    this.code,
    this.note,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    code: json["code"],
    note: json["note"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "code": code,
    "note": note,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class SaleProduct {
  int? id;
  String? saleId;
  String? productId;
  String? productName;
  String? quantity;
  String? price;
  dynamic discountPercent;
  String? total;
  dynamic batchNo;
  dynamic purchaseId;
  dynamic purchaseProductId;
  String? createdAt;
  String? updatedAt;
  dynamic discountAmount;
  String? packSizeId;
  String? packSizeQuantity;
  String? totalQuantity;

  SaleProduct({
    this.id,
    this.saleId,
    this.productId,
    this.productName,
    this.quantity,
    this.price,
    this.discountPercent,
    this.total,
    this.batchNo,
    this.purchaseId,
    this.purchaseProductId,
    this.createdAt,
    this.updatedAt,
    this.discountAmount,
    this.packSizeId,
    this.packSizeQuantity,
    this.totalQuantity,
  });

  factory SaleProduct.fromJson(Map<String, dynamic> json) => SaleProduct(
    id: json["id"],
    saleId: json["sale_id"],
    productId: json["product_id"],
    productName: json["product_name"],
    quantity: json["quantity"],
    price: json["price"],
    discountPercent: json["discount_percent"],
    total: json["total"],
    batchNo: json["batch_no"],
    purchaseId: json["purchase_id"],
    purchaseProductId: json["purchase_product_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    discountAmount: json["discount_amount"],
    packSizeId: json["pack_size_id"],
    packSizeQuantity: json["pack_size_quantity"],
    totalQuantity: json["total_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sale_id": saleId,
    "product_id": productId,
    "product_name": productName,
    "quantity": quantity,
    "price": price,
    "discount_percent": discountPercent,
    "total": total,
    "batch_no": batchNo,
    "purchase_id": purchaseId,
    "purchase_product_id": purchaseProductId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "discount_amount": discountAmount,
    "pack_size_id": packSizeId,
    "pack_size_quantity": packSizeQuantity,
    "total_quantity": totalQuantity,
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
