import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropDownWidget extends StatelessWidget {
  const CustomDropDownWidget({
    super.key,
    required this.selectedValue,
    required this.title,
    required this.valuesOfDropDownList,
    this.onChanged,
  });

  final String selectedValue;
  final String title;
  final List<String> valuesOfDropDownList;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 16.h),
          Container(
            padding: REdgeInsets.all(12),
            height: 56.h,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: ColorsManager.blue)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedValue,
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.blue,
                  ),
                ),
                DropdownButton<String>(
                    underline: const SizedBox(),
                    iconSize: 35.sp,
                    iconEnabledColor: ColorsManager.blue,
                    iconDisabledColor: ColorsManager.blue,
                    items: valuesOfDropDownList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: ColorsManager.balck),
                        ),
                      );
                    }).toList(),
                    onChanged: onChanged)
              ],
            ),
          )
        ],
      ),
    );
  }
}
