import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:isnad_worker/core/style/app_colors.dart';

class AppToast {
  static void error(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      textColor: AppColors.white,
      fontSize: 16.0.sp,
      backgroundColor: AppColors.errorText,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 6,
    );
  }

  static void success(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      textColor: AppColors.white,
      fontSize: 16.0.sp,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: AppColors.iconSuccess,
      timeInSecForIosWeb: 6,
    );
  }
}
