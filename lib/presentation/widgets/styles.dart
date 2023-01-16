import 'package:flutter/cupertino.dart';

class Styles {
  TextStyle extraBigSizeBoldText(Color color) {
    return TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: color);
  }

  TextStyle extraBigSizeText(Color color) {
    return TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: color);
  }

  TextStyle bigSizeBoldText(Color color) {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: color);
  }

  TextStyle bigSizeText(Color color) {
    return TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: color);
  }

  TextStyle normalSizeBoldText(Color color) {
    return TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: color);
  }

  TextStyle smallSizeText(Color color) {
    return TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: color);
  }

  TextStyle extraSmallSizeText(Color color) {
    return TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: color);
  }


}
