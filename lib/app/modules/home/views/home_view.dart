import 'package:delivery_app/app/core/helper/app_widgets.dart';
import 'package:delivery_app/app/core/style/app_colors.dart';
import 'package:delivery_app/app/routes/app_pages.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
              color: AppColors.secondaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 8,
                ),
                child: EasyDateTimeLine(
                  initialDate: DateTime.now(),

                  headerProps: EasyHeaderProps(showHeader: false),

                  timeLineProps: EasyTimeLineProps(),
                  onDateChange: (selectedDate) {},
                  activeColor: AppColors.primaryColor,

                  dayProps: const EasyDayProps(
                    todayHighlightStyle: TodayHighlightStyle.withBackground,
                    todayHighlightColor: AppColors.primaryAccentColor,
                  ),
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
            InkWell(
              onTap: () => {
                if(controller.deliveryStatus.value){
                  Get.toNamed(Routes.ORDERS),
                } else {
                  AppWidgets().getSnackBar(
                    message: 'Please enable delivery status first.',

                  ),
                }
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
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
                        'Pending Orders',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primaryColor,
                        size: 28,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            AppWidgets().gapH16(),



            // Your Order Card
            InkWell(
              onTap: () => {
                if(controller.deliveryStatus.value){
                  Get.toNamed(Routes.TRANSACTIONS),
                } else {
                  AppWidgets().getSnackBar(
                    message: 'Please enable delivery status first.',

                  ),
                }
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
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
                        'Transaction History',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primaryColor,
                        size: 28,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
