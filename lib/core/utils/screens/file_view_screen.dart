import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:isnad_worker/core/services/file_loader_service.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';
import 'package:open_filex/open_filex.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FileViewerScreen extends StatefulWidget {
  final String fileId;

  const FileViewerScreen({super.key, required this.fileId});

  @override
  State<FileViewerScreen> createState() => _FileViewerScreenState();
}

class _FileViewerScreenState extends State<FileViewerScreen> {
  late final Future<String?> _future;

  @override
  void initState() {
    super.initState();
    _future = downloadFileToTemp(widget.fileId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'file.title'.tr()),
      body: FutureBuilder<String?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) {
            return const Center(child: Text('Failed to load file'));
          }
          return _FileContent(filePath: snapshot.data!);
        },
      ),
    );
  }
}

class _FileContent extends StatefulWidget {
  final String filePath;

  const _FileContent({required this.filePath});

  @override
  State<_FileContent> createState() => _FileContentState();
}

class _FileContentState extends State<_FileContent> {
  late final Future<String> _mimeFuture;

  @override
  void initState() {
    super.initState();
    _mimeFuture = _detectMime(widget.filePath);
  }

  static Future<String> _detectMime(String path) async {
    final raf = await File(path).open();
    try {
      final header = await raf.read(12);
      return _detectMimeType(header);
    } finally {
      await raf.close();
    }
  }

  static String _detectMimeType(List<int> bytes) {
    if (bytes.length < 4) return 'application/octet-stream';

    if (bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF) {
      return 'image/jpeg';
    }
    if (bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47) {
      return 'image/png';
    }
    if (bytes[0] == 0x47 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x38) {
      return 'image/gif';
    }
    if (bytes[0] == 0x52 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x46) {
      return 'image/webp';
    }
    if (bytes[0] == 0x25 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x44 &&
        bytes[3] == 0x46) {
      return 'application/pdf';
    }

    return 'application/octet-stream';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _mimeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        final mime = snapshot.data ?? 'application/octet-stream';
        final file = File(widget.filePath);

        if (mime.startsWith('image/')) {
          return InteractiveViewer(child: Center(child: Image.file(file)));
        }

        if (mime == 'application/pdf') {
          return SfPdfViewer.file(file);
        }

        return Center(
          child: ElevatedButton.icon(
            onPressed: () => OpenFilex.open(widget.filePath, type: mime),
            icon: const Icon(Icons.open_in_new),
            label: const Text('Open with external app'),
          ),
        );
      },
    );
  }
}
