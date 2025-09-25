import 'package:flutter/material.dart';
import 'package:any_image_view/any_image_view.dart';
import 'package:get/get.dart';

import '../../../../generated/assets.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
   controller.initializeApp();
    return Scaffold(
      body: Center(
        child: AnyImageView(imagePath: Assets.logoIcon, height: 150, width: 
        150,borderRadius: BorderRadius.circular(14),),
      )
    );
  }
}
