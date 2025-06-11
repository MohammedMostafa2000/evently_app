import 'dart:developer';

import 'package:evently_app/data/firebase_services/firebase_sevices.dart';
import 'package:evently_app/data/models/event_data_model.dart';
import 'package:evently_app/main_layout/widgets/custom_map_event_card.dart';
import 'package:evently_app/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Maptab extends StatefulWidget {
  const Maptab({super.key});

  @override
  State<Maptab> createState() => _MaptabState();
}

class _MaptabState extends State<Maptab> {
  late ConfigProvider mainProvider;

  String get selectedCategoryId => '1';

  @override
  void initState() {
    super.initState();
    mainProvider = Provider.of<ConfigProvider>(context, listen: false);
    mainProvider.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConfigProvider>(
      builder: (context, provider, child) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            onMapCreated: (controller) {
              provider.googleMapController = controller;
            },
            onTap: (latLng) {
              provider.goToLocation(latLng);
            },
            initialCameraPosition: provider.initialCameraPosition,
            mapType: MapType.satellite,
            markers: provider.markers,
          ),
          Positioned(
            bottom: 120.h,
            left: 0.w,
            right: 0.w,
            child: SizedBox(
              height: 94.h,
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
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          log('${events[index].lat}, ${events[index].lng}');
                          provider
                              .goToLocation(LatLng(events[index].lat ?? 0, events[index].lng ?? 0));
                        },
                        child: CustomMapEventCard(
                          event: events[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
