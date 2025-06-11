import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes/routes_manager.dart';
import 'package:evently_app/main_layout/tabs/favorites/favorite.dart';
import 'package:evently_app/main_layout/tabs/home/home.dart';
import 'package:evently_app/main_layout/tabs/map/map.dart';
import 'package:evently_app/main_layout/tabs/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;
  List<Widget> tabs =const [
    Home(),
    Maptab(),
    Favorite(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: ColorsManager.light),
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {
          Navigator.pushNamed(context, RoutesManager.createEvent);
        },
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
      body: tabs[selectedIndex],
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomAppBar(
      height: 60.h,
      notchMargin: 5.r,
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          selectedIndex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(AssetsManager.homeFilledIcon),
            icon: SvgPicture.asset(AssetsManager.homeOutlinedIcon),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(AssetsManager.mapFilledIcon),
            icon: SvgPicture.asset(AssetsManager.mapOutlinedIcon),
            label: AppLocalizations.of(context)!.map,
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(AssetsManager.heartFilledIcon),
            icon: SvgPicture.asset(AssetsManager.heartOutlinedIcon),
            label: AppLocalizations.of(context)!.favorite,
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(AssetsManager.userFilledIcon),
            icon: SvgPicture.asset(AssetsManager.userOutlinedIcon),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
      ),
    );
  }
}
