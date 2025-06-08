import 'package:carousel_test/PlayerCarousel/stat_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({
    super.key,
    required this.playerName,
    this.backgroundColor = const Color(0xFFC27318),
    required this.imageProvider,
    required this.attributes,
    required this.animateBars,
  });

  final Color backgroundColor;
  final Color borderColor = Colors.black;
  final double borderRadius = 50;
  final double borderWidth = 5;

  final String playerName;
  final ImageProvider imageProvider;
  final List<Map<String, dynamic>> attributes;

  final bool animateBars;

  @override
  Widget build(BuildContext context) {
    final cardDimension = MediaQuery.of(context).size.height * 0.8;
    return Center(
      child: Stack(
        children: [
          Container(
            width: cardDimension,
            height: cardDimension,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: borderColor, width: borderWidth),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationZ(-0.05),
                        child: Image(image: imageProvider),
                      ),
                    ),
                    //Spacer(),
                    Expanded(
                      child: Column(
                        children: [
                          FittedBox(
                            child: Text(
                              playerName,
                              style: GoogleFonts.luckiestGuy(
                                fontSize: 34,
                                //height: 1.1,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: attributes.map((attribute) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: StatBar(
                                    label:
                                        attribute['label'], // Name des Attributs
                                    value:
                                        attribute['value'], // Wert des Attributs
                                    animated: animateBars,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/weapon1_profile.png"),
                      Image.asset("assets/images/weapon2_profile.png"),
                      Image.asset("assets/images/weapon3_profile.png"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/box_light.png',
              fit: BoxFit.cover,
              height: cardDimension, // Gleiche Höhe wie der Container
            ),
          ),
        ],
      ),
    );
  }
}
