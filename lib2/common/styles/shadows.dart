import 'package:flutter/widgets.dart';

import '../../utils/constants/colors.dart';

class TShadowStyle {
  static final verticalProductShadow = BoxShadow(
    // ignore: deprecated_member_use
    color: TColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );

  static final horizonalProductShadow = BoxShadow(
    // ignore: deprecated_member_use
    color: TColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}
