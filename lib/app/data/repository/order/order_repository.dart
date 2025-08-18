import 'package:delivery_app/app/data/model/order/order_status_response.dart';

import '../../../network_service/api_client.dart';
import '../../../network_service/api_end_points.dart';
import '../../model/order/order_data_response.dart';

class OrderRepository {
  Future<DelieveryOrderResponse> getOrderData() async {
    var response = await ApiClient().get(
      ApiEndPoints.orderData,
      getOrderData,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );

    return delieveryOrderResponseFromJson(response.toString());
  }

  Future<OrderStatusResponse> setOrderStatus(String orderId,String
  deliveryStatus,String reason,String amount) async {
    var response = await ApiClient().post(
      ApiEndPoints.orderStatus(orderId: orderId),
      {
        'delivery_status': deliveryStatus,
        'delivery_reject_reason':reason,
        'paid_amount': amount
      },
      setOrderStatus,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );

    return orderStatusResponseFromJson(response.toString());
  }
}
