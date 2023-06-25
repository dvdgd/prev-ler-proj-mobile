import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class FileConverter {
  Future<String> fileToBase64(String filePath) async {
    File file = File(filePath);
    Uint8List fileBytes = await file.readAsBytes();
    String fileBase64 = base64.encode(fileBytes);

    return fileBase64;
  }

  Uint8List base64Binary(String base64File) {
    Uint8List fileBytes = base64.decode(base64File);
    return fileBytes;
  }
}
