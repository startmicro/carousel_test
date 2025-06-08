// pubspec.yaml  – falls noch nicht geschehen:
// google_fonts: ^6.2.1

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatBar extends StatelessWidget {
  const StatBar({
    super.key,
    required this.label,
    required this.value,
    this.height = 25,
    this.barColor = const Color(0xFF2C20BF),
    this.fillColor = const Color(0xFF70C0B9),
    this.animated = true,
    this.animationDuration = const Duration(milliseconds: 800),
  });

  final String label;
  final int value;
  final double height;
  final Color barColor;
  final Color fillColor;
  final bool animated;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    final factor = value.clamp(0, 100) / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            label,
            style: GoogleFonts.archivo(
              fontSize: 16,
              color: Color(0xFF2A1C11),
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final fullWidth = constraints.maxWidth;
            final targetWidth = fullWidth * factor;

            return Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  width: fullWidth,
                  height: height,
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Positioned(
                  left: 3,
                  top: 3,
                  bottom: 3,
                  child: AnimatedContainer(
                    duration: animationDuration,
                    width: animated
                        ? targetWidth - 6
                        : 0, // animiert reinfahren
                    curve: Curves.easeOut,
                    decoration: BoxDecoration(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  child: Text(
                    value.toString(),
                    style: GoogleFonts.archivo(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
