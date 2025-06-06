import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/providers/set_location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SetLocation extends StatelessWidget {
  const SetLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SetLocationProvider(),
      child: Consumer<SetLocationProvider>(
        builder: (context, provider, child) => Scaffold(
          body: Column(
            children: [
              Expanded(
                child: GoogleMap(
                  onTap: (latLng) {
                    provider.changeSelectedLocation(latLng);
                    Navigator.pop(context, provider.selectedLocation);
                  },
                  onMapCreated: (controller) {
                    provider.googleMapController = controller;
                  },
                  markers: provider.markers,
                  initialCameraPosition: provider.initialCameraPosition,
                ),
              ),
              Container(
                padding: REdgeInsets.all(12),
                alignment: Alignment.center,
                width: double.infinity,
                color: ColorsManager.blue,
                child: Text(
                  'Tap on location to set',
                  style: TextStyle(
                    color: ColorsManager.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
