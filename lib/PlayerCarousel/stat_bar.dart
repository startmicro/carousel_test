// pubspec.yaml  – falls noch nicht geschehen:
// google_fonts: ^6.2.1

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatBar extends StatelessWidget {
  const StatBar({
    super.key,
    required this.label,            // „Geschwindigkeit“, „Stärke“ …
    required this.value,            // 0‒100
    this.height = 25,               // Höhe des Balkens
    this.barColor = const Color(0xFF2C20BF),    
    this.fillColor = const Color(0xFF70C0B9), 
  });

  final String label;
  final int value;          // erwartet 0-100
  final double height;
  final Color barColor;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    // Wert in 0-1 umrechnen und begrenzen
    final double factor = (value.clamp(0, 100)) / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Titel
        Text(
          label,
          style: GoogleFonts.archivo(
            fontSize: 16,
            color: Color(0xFF2A1C11),
            fontWeight: FontWeight.w600,
          ),
        ),
        //const SizedBox(height: 2),
        // 2. Balken – LayoutBuilder, um verfügbare Breite zu erfahren
        LayoutBuilder(
          builder: (context, constraints) {
            final fullWidth = constraints.maxWidth;
            final fillWidth = fullWidth * factor;

            return Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Blauer Grund-Balken (gerundete Ecken)
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
                  child: Container(
                    width: fillWidth - 4, // −4, um links + rechts je 2 px Luft zu lassen
                    color: fillColor,
                  ),
                ),
                // Wert-Zahl rechts
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
