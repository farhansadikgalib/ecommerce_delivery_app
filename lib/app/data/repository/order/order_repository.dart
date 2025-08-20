import 'package:delivery_app/app/data/model/order/order_status_response.dart';

import '../../../network_service/api_client.dart';
import '../../../network_service/api_end_points.dart';
import '../../model/order/order_data_response.dart';

class OrderRepository {
  Future<DeliveryOrderResponse> getOrderData() async {
    var response = await ApiClient().get(
      ApiEndPoints.orderData,
      getOrderData,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );

    return deliveryOrderResponseFromJson(response.toString());
  }

  Future<OrderStatusResponse> setOrderStatus(
    String orderId,
    String deliveryStatus,
    String reason,
    String amount,
  ) async {
    var response = await ApiClient().post(
      ApiEndPoints.orderStatus(orderId: orderId),
      {
        'delivery_status': deliveryStatus,
        'paid_amount': amount,
        if (deliveryStatus == '4') 'delivery_reject_reason': reason,
      },
      setOrderStatus,
      isHeaderRequired: true,
      isLoaderRequired: false,
    );

    return orderStatusResponseFromJson(response.toString());
  }
}
