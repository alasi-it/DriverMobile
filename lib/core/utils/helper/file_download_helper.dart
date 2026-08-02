import 'package:easy_localization/easy_localization.dart';
import 'package:isnad_worker/core/file_management/domain/use_case/download_file_use_case.dart';
import 'package:isnad_worker/core/utils/helper/app_toast.dart';
import 'package:isnad_worker/core/utils/service_locator/service_locator.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloadHelper {
  FileDownloadHelper._();

  static Future<bool> downloadAndOpen({
    required String fileId,
    required String fileName,
    String? mimeType,
  }) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final ext = _extFromMime(mimeType);
      final name = fileName.contains('.') ? fileName : '$fileName$ext';
      final filePath = '${dir.path}/$name';

      final result = await sl<DownloadFileUseCase>()(
        DownloadFileUseCaseParams(fileId: fileId, savePath: filePath),
      );

      String? errorMsg;
      result.fold((f) => errorMsg = f.errMessage, (_) => null);

      if (errorMsg != null) {
        AppToast.error(errorMsg!);
        return false;
      }

      AppToast.success('file_download.success'.tr());
      await OpenFilex.open(filePath);
      return true;
    } catch (_) {
      AppToast.error('file_download.failed'.tr());
      return false;
    }
  }

  static String _extFromMime(String? mime) => switch (mime) {
    'image/jpeg' => '.jpg',
    'image/png' => '.png',
    'image/gif' => '.gif',
    'image/webp' => '.webp',
    'application/pdf' => '.pdf',
    _ => '.pdf',
  };
}
