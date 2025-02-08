import 'package:flutter/material.dart';

extension MediaQueryExtensions on BuildContext {
  Size get mediaQuerySize => MediaQuery.of(this).size;
}
