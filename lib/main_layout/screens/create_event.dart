import 'package:evently_app/authentication/widgets/custom_text_button.dart';
import 'package:evently_app/authentication/widgets/custom_text_form_field.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes/routes_manager.dart';
import 'package:evently_app/data/firebase_services/firebase_sevices.dart';
import 'package:evently_app/data/models/event_data_model.dart';
import 'package:evently_app/data/models/tab_bar_data_model.dart';
import 'package:evently_app/main_layout/widgets/custom_tab_bar_widget.dart';
import 'package:evently_app/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  String selectedCategoryId = '1';
  late String selectedImagePath;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  List<TabBarDataModel> getTabsList(BuildContext context) {
    return [
      TabBarDataModel(
        id: '2',
        title: AppLocalizations.of(context)!.sports,
        icon: Icon(Icons.sports_soccer),
        imagePath: AssetsManager.sportsCard,
      ),
      TabBarDataModel(
        id: '3',
        title: AppLocalizations.of(context)!.birthday,
        icon: Icon(Icons.cake),
        imagePath: AssetsManager.birthdayCard,
      ),
      TabBarDataModel(
        id: '4',
        title: AppLocalizations.of(context)!.meeting,
        icon: Icon(Icons.meeting_room_outlined),
        imagePath: AssetsManager.meetingCard,
      ),
      TabBarDataModel(
        id: '5',
        title: AppLocalizations.of(context)!.gaming,
        icon: Icon(Icons.videogame_asset),
        imagePath: AssetsManager.gamingCard,
      ),
      TabBarDataModel(
        id: '6',
        title: AppLocalizations.of(context)!.eating,
        icon: Icon(Icons.restaurant),
        imagePath: AssetsManager.eatingCard,
      ),
      TabBarDataModel(
        id: '7',
        title: AppLocalizations.of(context)!.holiday,
        icon: Icon(Icons.beach_access),
        imagePath: AssetsManager.holidayCard,
      ),
      TabBarDataModel(
        id: '8',
        title: AppLocalizations.of(context)!.exhibition,
        icon: Icon(Icons.museum),
        imagePath: AssetsManager.exhibitionCard,
      ),
      TabBarDataModel(
        id: '9',
        title: AppLocalizations.of(context)!.work_shop,
        icon: Icon(Icons.handyman),
        imagePath: AssetsManager.workshopCard,
      ),
      TabBarDataModel(
        id: '10',
        title: AppLocalizations.of(context)!.book_club,
        icon: Icon(Icons.menu_book),
        imagePath: AssetsManager.bookclubCard,
      ),
    ];
  }

  LatLng? location;
  @override
  void initState() {
    super.initState();
    selectedImagePath = AssetsManager.sportsCard; // الصورة الافتراضية
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.create_event,
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  selectedImagePath,
                ),
              ),
              SizedBox(height: 16.h),
              CustomTabBarWidget(
                borderColor: ColorsManager.blue,
                tabsList: getTabsList(context),
                indicatorBackgroundColor: ColorsManager.blue,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: ColorsManager.blue,
                onTabSelected: (id) {
                  selectedCategoryId = id;
                  selectedImagePath =
                      getTabsList(context).firstWhere((element) => element.id == id).imagePath!;

                  setState(() {});
                },
              ),
              SizedBox(height: 16.h),
              Text(
                AppLocalizations.of(context)!.title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: titleController,
                hintText: AppLocalizations.of(context)!.event_title,
                prefixIcon: Icons.edit_square,
              ),
              SizedBox(height: 16.h),
              Text(
                AppLocalizations.of(context)!.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: descriptionController,
                hintText: AppLocalizations.of(context)!.event_description,
                maxLines: 5,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Icon(Icons.date_range_outlined),
                  SizedBox(width: 10.w),
                  Text(
                    '${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Spacer(),
                  CustomTextButton(
                    title: AppLocalizations.of(context)!.choose_date,
                    onPressed: () => selectEventDate(),
                  )
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(Icons.date_range_outlined),
                  SizedBox(width: 10.w),
                  Text(
                    DateFormat('h : m  a').format(
                      DateTime(0, 0, 0, selectedTime.hour, selectedTime.minute),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Spacer(),
                  CustomTextButton(
                    title: AppLocalizations.of(context)!.choose_time,
                    onPressed: () => selectEventTime(),
                  )
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                AppLocalizations.of(context)!.location,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 8.h),
              InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: () {
                  Navigator.pushNamed(context, RoutesManager.setLocation).then(
                    (value) {
                      if (value != null) {
                        location = value as LatLng;
                      }
                      setState(() {});
                    },
                  );
                },
                child: Container(
                  padding: REdgeInsets.all(8),
                  height: 62.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: ColorsManager.blue),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.blue,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: REdgeInsets.all(12),
                        child: Icon(
                          Icons.gps_fixed,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          location == null
                              ? AppLocalizations.of(context)!.choose_event_location
                              : '${location!.latitude}, ${location!.longitude}',
                          style: TextStyle(
                            color: ColorsManager.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: ColorsManager.blue,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              CustomElevatedButton(
                title: AppLocalizations.of(context)!.add_event,
                onPressed: () {
                  addEvent();
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  void addEvent() async {
    EventDataModel event = EventDataModel(
      title: titleController.text,
      description: descriptionController.text,
      categoryID: selectedCategoryId,
      eventID: '',
      dateTime: selectedDate,
      time: {
        'hour': selectedTime.hour,
        'minute': selectedTime.minute,
      },
    );
    try {
      await FirebaseSevices.addEventToFirestore(event);
    } on Exception catch (e) {
      print(e);
    }
  }

  void selectEventDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: selectedDate,
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void selectEventTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }
}
