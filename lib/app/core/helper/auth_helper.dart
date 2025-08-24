

import 'package:delivery_app/app/core/helper/shared_value_helper.dart';

import '../../data/model/auth/login_response.dart';


class AuthHelper {
  void setUserData(
      LoginResponse loginResponse) {
    if (loginResponse.token != null) {
      isLoggedIn.$ = true;
      isLoggedIn.save();

      userStatus.$ = loginResponse.user?.status=='1'?true:false;
      userStatus.save();

      accessToken.$ = "Bearer ${loginResponse.token}";
      accessToken.save();

      userName.$ = loginResponse.user!.name!;
      userName.save();

      userId.$ = loginResponse.user!.id!.toString();
      userId.save();

      userEmail.$ = loginResponse.user!.email!;
      userEmail.save();




    }
  }

  void clearUserData() {
    isLoggedIn.$ = false;
    isLoggedIn.save();

    userStatus.$ = false;
    userStatus.save();

    accessToken.$ = "";
    accessToken.save();


    userId.$ = "";
    userId.save();

    userName.$ = "";
    userName.save();


    userEmail.$ = "";
    userEmail.save();


  }

   loadItems() {
    isLoggedIn.load();
    userStatus.load();
    accessToken.load();
    userName.load();
    userId.load();
    userEmail.load();
    userRole.load();
  }
}
