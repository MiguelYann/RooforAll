import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:io' as Io;

class PictureProvider with ChangeNotifier {

  Future<Image> getImageFromPath(String path) async {
    final bytes = await Io.File(path).readAsBytes();
    final image64 = base64Encode(bytes);
    return Image.memory(base64Decode(image64));
  }
}