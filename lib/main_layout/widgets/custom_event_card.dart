import 'dart:developer';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/data/firebase_services/firebase_sevices.dart';
import 'package:evently_app/data/models/event_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomEventCard extends StatefulWidget {
  const CustomEventCard({
    super.key,
    required this.event,
  });
  final EventDataModel event;

  @override
  State<CustomEventCard> createState() => _CustomEventCardState();
}

class _CustomEventCardState extends State<CustomEventCard> {
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

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  @override
  Widget build(BuildContext context) {
    log('hiiiiiiiiiiiii');
    return Container(
      margin: REdgeInsets.only(
        bottom: 12,
        left: 12,
        right: 12,
        top: 0,
      ),
      padding: REdgeInsets.all(8),
      height: 204.h,
      width: 362.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsManager.blue,
        ),
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: AssetImage(categoryImages[widget.event.categoryID] ?? AssetsManager.birthdayCard),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: REdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                Text(
                  widget.event.dateTime.day.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Nov',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Container(
              height: 50.h,
              width: double.infinity,
              padding: REdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      widget.event.title,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                      isFavorite
                          ? FirebaseSevices.addFavoriteEventToFirestore(widget.event.eventID)
                          : FirebaseSevices.removeFavoriteEventToFirestore(widget.event.eventID);
                    },
                    icon: isFavorite
                        ? const Icon(Icons.favorite, color: ColorsManager.blue)
                        : const Icon(Icons.favorite_border),
                    iconSize: 24.sp,
                    color: ColorsManager.blue,
                  )
                ],
              ))
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
