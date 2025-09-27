import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/data/firebase_services/firebase_sevices.dart';
import 'package:evently_app/data/models/event_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';

class CustomMapEventCard extends StatefulWidget {
  const CustomMapEventCard({
    super.key,
    required this.event,
  });
  final EventDataModel event;

  @override
  State<CustomMapEventCard> createState() => _CustomEventCardState();
}

class _CustomEventCardState extends State<CustomMapEventCard> {
  bool isFavorite = false;

  final Map<String, String> categoryImages = {
    '2': AssetsManager.sportsCard,
    '3': AssetsManager.birthdayCard,
    '4': AssetsManager.meetingCard,
    '5': AssetsManager.gamingCard,
    '6': AssetsManager.eatingCard,
    '7': AssetsManager.holidayCard,
    '8': AssetsManager.exhibitionCard,
    '9': AssetsManager.workshopCard,
    '10': AssetsManager.bookclubCard,
  };

  String? address;

  Future<void> convertLatLngToAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        widget.event.lat ?? 0, widget.event.lng ?? 0);
    setState(() {
      address = '${placemarks[0].administrativeArea}, ${placemarks[0].country}';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
    convertLatLngToAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.symmetric(horizontal: 10),
      padding: REdgeInsets.all(8),
      height: 362.h,
      width: 250.w,
      decoration: BoxDecoration(
        color: ColorsManager.light,
        border: Border.all(
          color: ColorsManager.blue,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          SizedBox(
            height: double.infinity,
            width: 100.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(
                categoryImages[widget.event.categoryID]!,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 120.w,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  widget.event.title,
                  maxLines: 1,
                ),
              ),
              SizedBox(
                width: 120.w,
                child: Text(
                  address ?? 'loading...',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _loadFavoriteStatus() async {
    bool fav = await FirebaseSevices.checkFavoriteEvent(widget.event.eventID);
    setState(() {
      isFavorite = fav;
    });
  }
}
