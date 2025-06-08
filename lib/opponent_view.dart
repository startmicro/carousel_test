import 'package:carousel_test/slot_machine_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpponentView extends StatefulWidget {
  final Map<String, Object> profile;

  const OpponentView({super.key, required this.profile});

  @override
  State<OpponentView> createState() => _OpponentViewState();
}

class _OpponentViewState extends State<OpponentView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Passe die Dauer nach Bedarf an
      vsync: this,
    )..repeat(reverse: true); // Wiederhole die Animation umgekehrt

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/background.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(seconds: 2),
                          builder: (context, value, child) {
                            return Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF70C0B9,
                                    ).withOpacity(0.8 * value),
                                    spreadRadius: 5 * value,
                                    blurRadius: 15 * value,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: child,
                            );
                          },
                          child: SizedBox(
                            height: height * 0.7,
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationZ(-0.05),
                              child: Image(
                                image:
                                    widget.profile['image']
                                        as ImageProvider<Object>,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        Text(
                          widget.profile['name'] as String,
                          style: GoogleFonts.luckiestGuy(
                            fontSize: 34,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    //const SizedBox(width: 20),
                    Stack(
                      children: [
                        Text(
                          'VS',
                          style: GoogleFonts.koulen(
                            fontSize: 154,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 12
                              ..color = const Color(0xFF9DA892),
                          ),
                        ),
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFFFE875), Color(0xFFC27318)],
                              stops: [0.29, 0.90],
                            ).createShader(bounds);
                          },
                          child: Text(
                            'VS',
                            style: GoogleFonts.koulen(
                              fontSize: 154,
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .white, // Wichtig: Farbe muss hier gesetzt werden
                            ),
                          ),
                        ),
                      ],
                    ),
                    //const SizedBox(width: 20),
                    Column(
                      children: [
                        Container(
                          /*decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFA055).withOpacity(
                                  0.8,
                                ), // Schattenfarbe mit Transparenz
                                spreadRadius:
                                    5, // Wie weit sich der Schatten ausbreitet
                                blurRadius:
                                    15, // Weichzeichnungsradius des Schattens
                                offset: const Offset(
                                  0,
                                  3,
                                ), // Versatz des Schattens (horizontal, vertikal)
                              ),
                            ],
                          ),*/
                          child: SlotMachineProfile(
                            images: [
                              AssetImage('assets/images/max_profile.png'),
                              AssetImage('assets/images/placido_profile.png'),
                              AssetImage('assets/images/katzenia_profile.png'),
                            ],
                            names: ['Max', 'Placido', 'Katzenia'],
                            height: height * 0.7,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
