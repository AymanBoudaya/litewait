import 'package:caferesto/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';

class TSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: AppSizes.appBarHeight,
    left: AppSizes.defaultSpace,
    bottom: AppSizes.defaultSpace,
    right: AppSizes.defaultSpace,
  );
}
