import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogUtils {
  static showLoadingDialog(String? loadingMessage, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              if (loadingMessage != null) Text(loadingMessage),
              SizedBox(width: 30.w),
              const CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }

  static hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static showMessageDialog(String? message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              if (message != null) Expanded(child: Text(message)),
            ],
          ),
        );
      },
    );
  }
}
