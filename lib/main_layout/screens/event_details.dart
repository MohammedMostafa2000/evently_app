import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes/routes_manager.dart';
import 'package:evently_app/data/firebase_services/firebase_sevices.dart';
import 'package:evently_app/data/models/event_data_model.dart';
import 'package:evently_app/data/models/user_data_model.dart';
import 'package:evently_app/main_layout/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({
    super.key,
    required this.event,
  });
  final EventDataModel event;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final Map<String, String> imagesCategory = AssetsManager.imagesCategory;

  String? address;

  Future<void> convertLatLngToAddress() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(widget.event.lat ?? 0, widget.event.lng ?? 0);
    setState(() {
      address = '${placemarks[0].subAdministrativeArea}, ${placemarks[0].country}';
    });
  }

  @override
  void initState() {
    super.initState();
    convertLatLngToAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        actions: widget.event.userID == UserDataModel.currentUser!.id
            ? [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesManager.createEvent,
                        arguments: widget.event);
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    FirebaseSevices.deleteEvent(widget.event.eventID);
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: ColorsManager.red,
                  ),
                ),
              ]
            : [],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(
                    imagesCategory[widget.event.categoryID] ?? AssetsManager.sportsCard),
              ),
              SizedBox(height: 10.h),
              Text(
                widget.event.title,
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),
              CustomContainer(
                prefixIcon: Icons.calendar_month,
                title:
                    '${widget.event.dateTime.day} / ${widget.event.dateTime.month} / ${widget.event.dateTime.year} \n${DateFormat('h : mm  a').format(
                  DateTime(
                    0,
                    0,
                    0,
                    widget.event.dateTime.hour,
                    widget.event.dateTime.minute,
                  ),
                )}',
              ),
              SizedBox(height: 10.h),
              CustomContainer(
                suffixIcon: Icons.arrow_forward_ios_rounded,
                prefixIcon: Icons.gps_fixed,
                title: address ?? 'Loading address...',
              ),
              SizedBox(height: 10.h),
              Container(
                height: 360.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: ColorsManager.blue,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: GoogleMap(
                    rotateGesturesEnabled: false,
                    scrollGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    zoomGesturesEnabled: false,
                    initialCameraPosition: CameraPosition(
                      zoom: 13,
                      target: LatLng(widget.event.lat ?? 0, widget.event.lng ?? 0),
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('1'),
                        position: LatLng(widget.event.lat ?? 0, widget.event.lng ?? 0),
                      ),
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Description\n\n${widget.event.description}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
