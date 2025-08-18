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
  String? transactionId;
  String? orderId;
  String? customerId;
  String? transactionDate;
  String? amount;
  String? type; // credit/debit
  String? status; // pending/completed/failed
  String? paymentMethod;
  String? description;
  String? createdAt;
  String? updatedAt;
  CustomerInfo? customer;
  OrderInfo? order;

  TransactionData({
    this.id,
    this.transactionId,
    this.orderId,
    this.customerId,
    this.transactionDate,
    this.amount,
    this.type,
    this.status,
    this.paymentMethod,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.customer,
    this.order,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) => TransactionData(
    id: json["id"],
    transactionId: json["transaction_id"],
    orderId: json["order_id"],
    customerId: json["customer_id"],
    transactionDate: json["transaction_date"],
    amount: json["amount"],
    type: json["type"],
    status: json["status"],
    paymentMethod: json["payment_method"],
    description: json["description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    customer: json["customer"] == null ? null : CustomerInfo.fromJson(json["customer"]),
    order: json["order"] == null ? null : OrderInfo.fromJson(json["order"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_id": transactionId,
    "order_id": orderId,
    "customer_id": customerId,
    "transaction_date": transactionDate,
    "amount": amount,
    "type": type,
    "status": status,
    "payment_method": paymentMethod,
    "description": description,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "customer": customer?.toJson(),
    "order": order?.toJson(),
  };
}

class CustomerInfo {
  int? id;
  String? fullName;
  String? mobile;
  String? email;

  CustomerInfo({
    this.id,
    this.fullName,
    this.mobile,
    this.email,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
    id: json["id"],
    fullName: json["full_name"],
    mobile: json["mobile"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "mobile": mobile,
    "email": email,
  };
}

class OrderInfo {
  int? id;
  String? saleCode;
  String? total;

  OrderInfo({
    this.id,
    this.saleCode,
    this.total,
  });

  factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
    id: json["id"],
    saleCode: json["sale_code"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sale_code": saleCode,
    "total": total,
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
