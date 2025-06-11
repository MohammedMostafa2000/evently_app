import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.location,
    required this.prefixIcon,
    this.suffixIcon,
    required this.title,
  });
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final String title;
  final LatLng? location;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              prefixIcon,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              title,
              // location == null
              //     ? AppLocalizations.of(context)!.choose_event_location
              //     : '${location!.latitude}, ${location!.longitude}',
              style: const TextStyle(
                color: ColorsManager.blue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(
            suffixIcon,
            color: ColorsManager.blue,
          ),
        ],
      ),
    );
  }
}
