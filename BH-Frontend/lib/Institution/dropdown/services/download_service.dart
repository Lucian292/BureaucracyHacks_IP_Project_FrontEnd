import 'dart:html' as html;

class FileDownloader {
  Future<void> downloadFile(int documentId) async {
    String url = 'http://localhost:6969/api/tasks/download/byId/$documentId';
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }
}
