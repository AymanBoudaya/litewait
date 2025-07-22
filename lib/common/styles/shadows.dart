import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class TShadowStyle {
  static final verticalProductShadow = BoxShadow(
    // ignore: deprecated_member_use
    color: AppColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  static final horizontalProductShadow = BoxShadow(
    // ignore: deprecated_member_use
    color: AppColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  static final vericalCardProductShadow = BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 16,
    offset: const Offset(0, 8),
  );
}
