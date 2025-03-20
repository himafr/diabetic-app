import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class DownloadButton extends StatelessWidget {
  final String fileUrl;

  DownloadButton({required this.fileUrl});

  void _downloadFile() async {
    if (await canLaunch(fileUrl)) {
      await launch(fileUrl);
    } else {
      throw 'Could not launch $fileUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _downloadFile,
      child: Icon(Icons.download),
    );
  }
}
