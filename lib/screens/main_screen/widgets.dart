import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_flutter/utils/color.dart';
import 'package:weather_app_flutter/utils/text.dart';

class FrostedGlassBox extends StatelessWidget {
  final double theWidth;
  final double theHeight;
  final Widget? theChild;

  const FrostedGlassBox(
      {required this.theWidth, required this.theHeight, required this.theChild, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: theWidth,
        height: theHeight,
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 25,
                sigmaY: 25,
              ),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.13)),
                  gradient: LinearGradient(
                    colors: [Color(0xff5936B4).withOpacity(.7), Color(0xff362A84).withOpacity(.35)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
            ),
            Center(child: theChild),
          ],
        ),
      ),
    );
  }
}

class ForecastTile extends StatelessWidget {
  const ForecastTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
          BoxShadow(
            offset: Offset(20, 20),
            blurRadius: 100,
            color: Colors.black,
          )
        ]),
        width: 70,
        height: 180,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 30,
                sigmaY: 30,
              ),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white.withOpacity(0.13)),
                  gradient: LinearGradient(
                    colors: [Color(0xff5936B4).withOpacity(.8), Color(0xff362A84).withOpacity(.4)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  )),
            ),
            Center(
                child: Column(
              children: [
                Text('12:30'),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class TempDisplayWidget extends StatelessWidget {
  final String cityName, temp, weather, high, low, feelsLike;
  const TempDisplayWidget(
      {super.key,
      required this.cityName,
      required this.temp,
      required this.weather,
      required this.high,
      required this.low,
      required this.feelsLike});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          cityName.capitalize,
          style: GoogleFonts.nunito(
            fontSize: 50,
            color: AppColors.primary,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          '$temp°',
          style: GoogleFonts.nunito(
            fontSize: 110,
            color: AppColors.primary,
            fontWeight: FontWeight.w200,
          ),
        ),
        Text(
          'Mostly $weather',
          style: GoogleFonts.nunito(
            fontSize: 30,
            fontWeight: FontWeight.w400,
            color: AppColors.tertiary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Feels Like : $feelsLike°',
          style: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'H : $high°',
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'L : $low°',
              style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
              ),
            )
          ],
        )
      ],
    );
  }
}
