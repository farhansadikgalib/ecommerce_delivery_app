import 'package:shared_value/shared_value.dart';

final SharedValue<bool> isLoggedIn = SharedValue(
  value: false,
  key: "isLoggedIn",
);

final SharedValue<bool> userStatus = SharedValue(
  value: false,
  key: "userStatus",
);
final SharedValue<String> accessToken = SharedValue(
  value: "",
  key: "accessToken",
);


final SharedValue<String> userEmail = SharedValue(
  value: "",
  key: "designation",
);
final SharedValue<String> userName = SharedValue(
  value: "",
  key: "userName",
);

final SharedValue<String> userId = SharedValue(
  value: "",
  key: "userId",
);

final SharedValue<String> userRole = SharedValue(
  value: "",
  key: "userRole",
);


