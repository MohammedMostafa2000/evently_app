import 'package:evently_app/data/models/tab_bar_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBarItem extends StatelessWidget {
  const CustomTabBarItem({
    super.key,
    required this.tabBarDataModel,
    required this.borderColor,
  });
  final TabBarDataModel tabBarDataModel;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46.r),
        border: Border.all(color: borderColor),
      ),
      padding: REdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Center(
        child: Row(
          children: [
            tabBarDataModel.icon,
            SizedBox(width: 10.w),
            Text(tabBarDataModel.title),
          ],
        ),
      ),
    );
  }
}
