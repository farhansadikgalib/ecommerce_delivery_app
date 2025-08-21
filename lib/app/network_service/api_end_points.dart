class ApiEndPoints {
  //Authentication
  static String login = "delivery-user-login";
  static String signup = "user-register";
  static String verifyOtp = "user/verify";
  static String forgetPassword = "user/forgot-password";
  static String updatePassword = "user/update-password";
  static String logout = "user/logout";

  //Authentication

  //delivery status
  static String deliveryStatus = "delivery/status-update";

  //delivery status

  //order data
  static String pendingOrderData ({required String page}) =>
      "delivery/all-pending-order-list-paginated?page=$page&search"
      "=&paginate=20";

  static String allOrderData({required String page}) =>
      "delivery/all-ord"
      "er-list-paginated?page"
      "=$page&search"
      "=&paginate=20";

  static String orderStatus({required String orderId}) =>
      "delivery/order-delivery-status/$orderId";

  //order data

  //transaction data
  static String transactionData({required String page}) =>
      "delivery/all-delivery-transaction-list?page=$page&search=&paginate=20";

  static String transferToCompany({required String orderId}) =>
      "delivery/payment-transfer-to-company/$orderId";
  //transaction data
}
