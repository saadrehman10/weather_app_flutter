import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0x0ff00000);
  static const Color secondary = Color(0xff86878d);
  static const Color tertiary = Color(0xffbdbfc4);
  static const Color quaternary = Color(0xffd3d5da);

  static const LinearGradient linerGradientPrimary = LinearGradient(
    colors: [Color(0xff2E335A), Color(0xff1C1B33)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient linerGradientSecondary = LinearGradient(
    colors: [Color(0xff5936B4), Color(0xff362A84)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient linerGradientTertiary = LinearGradient(
    colors: [Color(0xff3658B1), Color(0xffC159EC)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient linerGradientQuaternary = LinearGradient(
    colors: [Color(0xffAEC9FF), Color(0xff083072)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const RadialGradient radialGradientPrimary = RadialGradient(
    colors: [Color(0xffF7CBFD), Color(0xff7758D1)],
    center: Alignment.bottomLeft,
  );
}
