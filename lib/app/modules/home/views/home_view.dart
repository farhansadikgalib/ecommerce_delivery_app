import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeView'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () => Get.toNamed('/order-verification'),
            child: const Text('Order & Address Verification'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/packaging'),
            child: const Text('Packaging'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/delivery-login'),
            child: const Text('Delivery Login'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/courier'),
            child: const Text('Courier & Transportation'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/tracking'),
            child: const Text('Tracking & Notifications'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/cash-collection'),
            child: const Text('Delivery & Cash Collection'),
          ),
          ElevatedButton(
            onPressed: () => Get.toNamed('/proof-of-delivery'),
            child: const Text('Proof of Delivery'),
          ),
        ],
      ),
    );
  }
}
