import 'package:evently_app/core/routes/routes_manager.dart';
import 'package:evently_app/data/firebase_services/firebase_sevices.dart';
import 'package:evently_app/data/models/event_data_model.dart';
import 'package:evently_app/data/models/tab_bar_data_model.dart';
import 'package:evently_app/data/models/user_data_model.dart';
import 'package:evently_app/main_layout/widgets/custom_event_card.dart';
import 'package:evently_app/main_layout/widgets/custom_tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TabBarDataModel> getTabsList(BuildContext context) {
    return [
      TabBarDataModel(
        id: '1',
        title: AppLocalizations.of(context)!.all,
        icon: const Icon(Icons.explore_outlined),
      ),
      TabBarDataModel(
        id: '2',
        title: AppLocalizations.of(context)!.sports,
        icon: const Icon(Icons.sports_soccer),
      ),
      TabBarDataModel(
        id: '3',
        title: AppLocalizations.of(context)!.birthday,
        icon: const Icon(Icons.cake),
      ),
      TabBarDataModel(
        id: '4',
        title: AppLocalizations.of(context)!.meeting,
        icon: const Icon(Icons.meeting_room_outlined),
      ),
      TabBarDataModel(
        id: '5',
        title: AppLocalizations.of(context)!.gaming,
        icon: const Icon(Icons.videogame_asset),
      ),
      TabBarDataModel(
        id: '6',
        title: AppLocalizations.of(context)!.eating,
        icon: const Icon(Icons.restaurant),
      ),
      TabBarDataModel(
        id: '7',
        title: AppLocalizations.of(context)!.holiday,
        icon: const Icon(Icons.beach_access),
      ),
      TabBarDataModel(
        id: '8',
        title: AppLocalizations.of(context)!.exhibition,
        icon: const Icon(Icons.museum),
      ),
      TabBarDataModel(
        id: '9',
        title: AppLocalizations.of(context)!.work_shop,
        icon: const Icon(Icons.handyman),
      ),
      TabBarDataModel(
        id: '10',
        title: AppLocalizations.of(context)!.book_club,
        icon: const Icon(Icons.menu_book),
      ),
    ];
  }

  String selectedCategoryId = '1'; // Default category is 'All'

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: REdgeInsets.symmetric(horizontal: 16.r),
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorsManager.blue,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(36.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 44.h),
              Text(
                '${AppLocalizations.of(context)!.welcome_back} ✨',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                UserDataModel.currentUser!.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  const Icon(
                    Icons.place_outlined,
                    color: ColorsManager.light,
                  ),
                  Text(
                    ' Cairo , Egypt',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              CustomTabBarWidget(
                onTabSelected: (id) {
                  selectedCategoryId = id;
                  setState(() {});
                },
                indicatorBackgroundColor: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).primaryColor,
                tabsList: getTabsList(context),
                labelColor: ColorsManager.blue,
                unselectedLabelColor: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
        // SizedBox(height: 8.h),
        Expanded(
          child: StreamBuilder<List<EventDataModel>>(
            stream: FirebaseSevices.getEventsStreamFromFirestore(selectedCategoryId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("حصل خطأ: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("لا يوجد بيانات"));
              }

              final events = snapshot.data!;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesManager.eventDetails,
                            arguments: events[index]);
                      },
                      child: CustomEventCard(event: events[index]));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
