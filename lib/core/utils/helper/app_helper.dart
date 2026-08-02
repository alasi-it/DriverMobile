// import 'dart:io';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:open_file/open_file.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:mime/mime.dart';
// import 'package:dio/dio.dart';
// import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../network/local/cache/cache_helper.dart';
// import '../network/remote/apis/dio_helper.dart';
// import 'app_navigator.dart';
// import 'app_toast.dart';

// class AppHelper {
//   static UserModel? get authUser {
//     return UserCubit.get(AppNavigator.context).user;
//   }

//   static String getInitialsFromName(String fullName) {
//     if (fullName.trim().isEmpty) return "";
//     List<String> parts = fullName.trim().split(RegExp(r"\s+"));
//     if (parts.length == 1) {
//       String name = parts[0];
//       return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
//     } else {
//       String first = parts.first[0];
//       String last = parts.last[0];
//       return ("$first$last").toUpperCase();
//     }
//   }

//   /// LAUNCH URL
//   static Future<bool> urlLauncher({required String url}) async {
//     if (!await launchUrl(
//       Uri.parse(url),
//       mode: LaunchMode.externalApplication,
//     )) {
//       throw Exception('Could not launch $url');
//     }
//     return false;
//   }

//   /// CLOSE KEYBOARD
//   static Future closeKeyboard() async {
//     FocusManager.instance.primaryFocus?.unfocus();
//   }

//   /// COPY TEXT
//   static Future<void> copyText(String text) async {
//     await Clipboard.setData(ClipboardData(text: text));
//   }

//   /// PICK FILE FROM DEVICE
//   static Future<List<PlatformFile>> pickFiles({
//     bool allowMultiple = true,
//     List<String>? allowedExtensions,
//   }) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: allowMultiple,
//       allowedExtensions: allowedExtensions,
//       type: allowedExtensions != null ? FileType.custom : FileType.any,
//     );
//     return result?.files ?? [];
//   }

//   /// HANDLE FILE BEFORE SEND TO APIS
//   static Future<MultipartFile> prepareFileForUpload(String path) async {
//     String? mimeType = lookupMimeType(path);
//     MediaType? mediaType;
//     if (mimeType != null) {
//       List<String> types = mimeType.split('/');
//       if (types.length == 2) mediaType = MediaType(types[0], types[1]);
//     }
//     var file = File(path);
//     return MultipartFile.fromStream(
//       () => file.openRead(),
//       await file.length(),
//       filename: file.path.split('/').last,
//       contentType: mediaType ?? MediaType('application', 'octet-stream'),
//     );
//   }

//   /// DOWNLOAD FILE AND OPEN ON DEVICE
//   static Future<void> downloadAndOpenFile(
//     String attachment, {
//     bool serve = false,
//   }) async {
//     try {
//       AppNavigator.push(
//         const Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Center(child: CircularProgressIndicator()),
//         ),
//       );
//       final tempDir = await getTemporaryDirectory();
//       final filePath = '${tempDir.path}/${attachment.split('/').last}';
//       final file = File(filePath);
//       final api = serve ? 'files/download?FilePath=$attachment' : attachment;
//       await DioHelper.download(url: api, savePath: filePath);
//       await OpenFile.open(file.path);
//       AppNavigator.pop();
//     } catch (e) {
//       AppNavigator.pop();
//       AppToast.error('Error: $e');
//     }
//   }

//   /// TIME FORMAT
//   static String timeFormat(String? time, String format) {
//     if (time == null) return '';
//     final String lang = CacheHelper.get('lang');
//     DateTime parsedTime = DateTime.parse(time).toLocal();
//     String formattedTime = DateFormat(format, lang).format(parsedTime);
//     return formattedTime;
//   }

//   /// TIME AGO
//   static String timeAgo(String? time) {
//     if (time == null) return '';
//     DateTime parsed = DateTime.parse(time).toLocal();
//     DateTime now = DateTime.now();
//     Duration difference = now.difference(parsed);
//     if (difference.isNegative) {
//       return '';
//     } else if (difference.inSeconds < 60) {
//       return '${difference.inSeconds} s';
//     } else if (difference.inMinutes < 60) {
//       return '${difference.inMinutes} m';
//     } else if (difference.inHours < 24) {
//       return '${difference.inHours} h';
//     } else if (difference.inDays < 7) {
//       return '${difference.inDays} d';
//     } else if (difference.inDays < 30) {
//       return '${(difference.inDays / 7).floor()} w';
//     } else if (difference.inDays < 365) {
//       int months = (now.year - parsed.year) * 12 + (now.month - parsed.month);
//       if (now.day < parsed.day) months -= 1;
//       return '$months m';
//     } else {
//       int years = now.year - parsed.year;
//       if (now.month < parsed.month ||
//           (now.month == parsed.month && now.day < parsed.day)) {
//         years -= 1;
//       }
//       return '$years y';
//     }
//   }

//   static Future<DateTime?> pickDate({
//     DateTime? min,
//     DateTime? initial,
//     DateTime? max,
//   }) async {
//     return await showDatePicker(
//       context: AppNavigator.context,
//       firstDate: min ?? DateTime.now(),
//       initialDate: initial ?? min ?? DateTime.now(),
//       lastDate: max ?? DateTime.parse("2222-12-31"),
//     );
//   }

//   static Future<TimeOfDay?> pickTime({TimeOfDay? initial}) async {
//     final ctx = AppNavigator.key.currentContext;
//     if (ctx != null) {
//       return await showTimePicker(
//         context: ctx,
//         initialTime: initial ?? TimeOfDay.now(),
//       );
//     }
//     return null;
//   }

//   /// Fetch device information based on the platform (Android/iOS)
//   static Future<Map<String, String>> getDeviceInfo() async {
//     final deviceInfoPlugin = DeviceInfoPlugin();
//     final deviceInfo = <String, String>{};
//     try {
//       if (Platform.isAndroid) {
//         final androidInfo = await deviceInfoPlugin.androidInfo;
//         deviceInfo['platform'] = 'android';
//         deviceInfo['manufacturer'] = androidInfo.manufacturer;
//         deviceInfo['model'] = androidInfo.model;
//         deviceInfo['osVersion'] = androidInfo.version.release;
//         deviceInfo['deviceId'] = androidInfo.id;
//       } else if (Platform.isIOS) {
//         final iosInfo = await deviceInfoPlugin.iosInfo;
//         deviceInfo['platform'] = 'ios';
//         deviceInfo['manufacturer'] = 'Apple';
//         deviceInfo['model'] = iosInfo.utsname.machine;
//         deviceInfo['osVersion'] = iosInfo.systemVersion;
//         deviceInfo['deviceId'] = iosInfo.identifierForVendor ?? 'Unknown';
//       }
//     } catch (e) {
//       debugPrint('Error fetching device info: $e');
//     }
//     return deviceInfo;
//   }

//   /// Get the app version dynamically using the package_info_plus plugin
//   static Future<PackageInfo?> getPlatformInfo() async {
//     try {
//       return await PackageInfo.fromPlatform();
//     } catch (e) {
//       return null;
//     }
//   }

//   static Future<String?> scanQrCode() async {
//     String? res = await SimpleBarcodeScanner.scanBarcode(
//       AppNavigator.context,
//       scanType: ScanType.qr,
//       scanFormat: ScanFormat.ONLY_QR_CODE,
//       barcodeAppBar: const BarcodeAppBar(
//         appBarTitle: 'Scan QR Code',
//         centerTitle: false,
//         enableBackButton: true,
//         backButtonIcon: Icon(Icons.arrow_back_ios),
//       ),
//       isShowFlashIcon: true,
//       delayMillis: 2000,
//       cameraFace: CameraFace.back,
//     );
//     return res;
//   }
// }
