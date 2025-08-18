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
  static String orderData = "delivery/all-order-list-paginated?page=1&search=&paginate=20";
  static String orderStatus({required String orderId}) =>
      "delivery/order-delivery-status/$orderId";
  //order data

  //transaction data
  static String transactionData = "delivery/all-delivery-transaction-list";
  //transaction data


}
