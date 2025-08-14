import 'package:delivery_app/app/core/helper/app_widgets.dart';
import 'package:delivery_app/app/core/style/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int todayWeekday = now.weekday % 7;
    DateTime startOfWeek = now.subtract(Duration(days: todayWeekday));
    List<DateTime> weekDays = List.generate(
      7,
      (i) => startOfWeek.add(Duration(days: i)),
    );

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppWidgets().gapH24(),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: AppColors.primaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              now.day.toString(),
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          ['S', 'M', 'T', 'W', 'T', 'F', 'S'][now.weekday % 7],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            AppWidgets().gapH16(),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.today,
                            color: AppColors.primaryColor,
                            size: 32,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Daily Delivery',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '৳ 1,250.00',
                            style: TextStyle(
                              fontSize: 24,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AppWidgets().gapW8(),
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 8,
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: AppColors.primaryColor,
                            size: 32,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Monthly Delivery',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '৳ 32,500.00',
                            style: TextStyle(
                              fontSize: 24,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),

            // Delivery Status Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.delivery_dining,
                          color: AppColors.primaryColor,
                          size: 28,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Delivery Status',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => Switch(
                        value: controller.deliveryStatus.value,
                        activeColor: AppColors.primaryColor,
                        onChanged: (val) {
                          controller.deliveryStatus.value = val;
                          controller.setDeliveryStatus();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppWidgets().gapH16(),

            // Your Order Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_bag,
                      color: AppColors.primaryColor,
                      size: 28,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Your Order',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
