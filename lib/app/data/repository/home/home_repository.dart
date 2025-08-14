import 'package:delivery_app/app/data/model/home/delivery_status_response.dart';
import '../../../network_service/api_client.dart';
import '../../../network_service/api_end_points.dart';

class HomeRepository {
  Future<DeliveryStatusResponse> userStatus(String status) async {
    var response = await ApiClient().post(
      ApiEndPoints.deliveryStatus,
      {"status": status},
      userStatus,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );

    return deliveryStatusResponseFromJson(response.toString());
  }
}
