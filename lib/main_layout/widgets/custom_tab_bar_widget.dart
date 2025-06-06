import 'package:evently_app/data/models/tab_bar_data_model.dart';
import 'package:evently_app/widgets/custom_tab_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({
    super.key,
    required this.tabsList,
    required this.labelColor,
    required this.unselectedLabelColor,
    required this.borderColor,
    required this.indicatorBackgroundColor,
    this.onTabSelected,
  });

  final List<TabBarDataModel> tabsList;
  final Color indicatorBackgroundColor;
  final Color labelColor;
  final Color unselectedLabelColor;
  final Color borderColor;
  final void Function(String)? onTabSelected;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabsList.length,
      child: TabBar(
        splashFactory: NoSplash.splashFactory,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(46.r), color: indicatorBackgroundColor),
        labelColor: labelColor,
        unselectedLabelColor: unselectedLabelColor,
        isScrollable: true,
        physics: BouncingScrollPhysics(),
        onTap: (index) {
          onTabSelected?.call(tabsList[index].id);
        },
        tabs: tabsList
            .map((tab) => CustomTabBarItem(
                  tabBarDataModel: tab,
                  borderColor: borderColor,
                ))
            .toList(),
      ),
    );
  }
}
