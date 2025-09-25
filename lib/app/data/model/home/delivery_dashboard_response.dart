import 'dart:convert';

DeliveryDashboardResponse deliveryDashboardResponseFromJson(String str) => DeliveryDashboardResponse.fromJson(json.decode(str));

String deliveryDashboardResponseToJson(DeliveryDashboardResponse data) => json.encode(data.toJson());

class DeliveryDashboardResponse {
  String? todayDeliveryAmount;
  String? monthlyDeliveryAmount;

  DeliveryDashboardResponse({
    this.todayDeliveryAmount,
    this.monthlyDeliveryAmount,
  });

  factory DeliveryDashboardResponse.fromJson(Map<String, dynamic> json) => DeliveryDashboardResponse(
    todayDeliveryAmount: json["today_delivery_amount"],
    monthlyDeliveryAmount: json["monthly_delivery_amount"],
  );

  Map<String, dynamic> toJson() => {
    "today_delivery_amount": todayDeliveryAmount,
    "monthly_delivery_amount": monthlyDeliveryAmount,
  };
}
