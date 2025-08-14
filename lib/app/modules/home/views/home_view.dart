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
    List<DateTime> weekDays = List.generate(7, (i) => startOfWeek.add(Duration(days: i)));

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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: AppColors.primaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(weekDays.length, (i) {
                    final date = weekDays[i];
                    final isToday = date.day == now.day && date.month == now.month && date.year == now.year;
                    final isCenter = i == 3;
                    return Column(
                      children: [

                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isToday ? Colors.white : AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: isCenter ? Colors.white : AppColors.primaryColor, width: isCenter ? 2 : 1),
                          ),
                          child: Center(
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(
                                color: isToday ? AppColors.primaryColor : Colors.white,
                                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          ['S', 'M', 'T', 'W', 'T', 'F', 'S'][date.weekday % 7],
                          style: TextStyle(
                            color: isToday ? Colors.white : Colors.white70,
                            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            AppWidgets().gapH16(),
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.today, color: AppColors.primaryColor, size: 32),
                          SizedBox(height: 8),
                          Text('Daily Delivery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(height: 8),
                          Text('৳ 1,250.00', style: TextStyle(fontSize: 24, color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
               AppWidgets().gapW8(),
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                      child: Column(
                        children: [
                          Icon(Icons.calendar_month, color: AppColors.primaryColor, size: 32),
                          SizedBox(height: 8),
                          Text('Monthly Delivery', style: TextStyle
                            (fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(height: 8),
                          Text('৳ 32,500.00', style: TextStyle(fontSize: 24, color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
