import 'package:carousel_test/PlayerCarousel/player_card.dart';
import 'package:carousel_test/opponent_view.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  /// Wir starten auf Seite 1 (Index 1) – so ist **Katzenia** (profil2) direkt in der Mitte,
  /// links Placido und rechts Max.
  late final PageController _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.5,
  );

  double _currentPage = 1; // default‑Wert synchron zum initialPage

  static const List<Map<String, Object>> profiles = [
    {
      'name': 'Placido',
      'backgroundColor': Color(0xFFC27318),
      'image': AssetImage('assets/images/placido_profile.png'),
      'attributes': [
        {'label': 'Speed', 'value': 30},
        {'label': 'Strength', 'value': 60},
        {'label': 'Jump', 'value': 80},
      ],
    },
    {
      'name': 'Katzenia',
      'backgroundColor': Color(0xFFB15BD3),
      'image': AssetImage('assets/images/katzenia_profile.png'),
      'attributes': [
        {'label': 'Speed', 'value': 90},
        {'label': 'Strength', 'value': 65},
        {'label': 'Jump', 'value': 85},
      ],
    },
    {
      'name': 'Max',
      'backgroundColor': Color(0xFF837F5D),
      'image': AssetImage('assets/images/max_profile.png'),
      'attributes': [
        {'label': 'Speed', 'value': 92},
        {'label': 'Strength', 'value': 70},
        {'label': 'Jump', 'value': 88},
      ],
    },
    {
      'name': 'Placido',
      'backgroundColor': Color(0xFFC27318),
      'image': AssetImage('assets/images/placido_profile.png'),
      'attributes': [
        {'label': 'Speed', 'value': 30},
        {'label': 'Strength', 'value': 60},
        {'label': 'Jump', 'value': 80},
      ],
    },
    {
      'name': 'Max',
      'backgroundColor': Color(0xFF837F5D),
      'image': AssetImage('assets/images/max_profile.png'),
      'attributes': [
        {'label': 'Speed', 'value': 92},
        {'label': 'Strength', 'value': 70},
        {'label': 'Jump', 'value': 88},
      ],
    },
    {
      'name': 'Katzenia',
      'backgroundColor': Color(0xFFB15BD3),
      'image': AssetImage('assets/images/katzenia_profile.png'),
      'attributes': [
        {'label': 'Speed', 'value': 90},
        {'label': 'Strength', 'value': 65},
        {'label': 'Jump', 'value': 85},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() => _currentPage = _pageController.page ?? 1);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int page) {
    if (page < 0 || page >= profiles.length) return;
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width;
    //final height = MediaQuery.of(context).size.width;
    //final buttonPosition = width / 2;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/background.png", // Path to the image
            fit: BoxFit.cover, // Adjust the image to cover the screen
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        itemCount: profiles.length,
                        itemBuilder: (context, index) {
                          final profile = profiles[index];
                          final difference = (index - _currentPage).abs();

                          final isActive = difference < 0.1;

                          final opacity = 1 - difference * 0.6;

                          // Berechne die Drehung basierend auf der Position
                          final rotationAngle =
                              (index - _currentPage) *
                              0.1; // Passe den Faktor 0.1 an, um die Drehungsstärke zu ändern

                          return Opacity(
                            opacity: opacity.clamp(0.2, 1.0),
                            child: Transform.rotate(
                              // Verwende Transform.rotate, um die Karte zu drehen
                              angle: rotationAngle,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    if (isActive) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OpponentView(
                                            profile: profile,
                                          ), // Übergib das Profil
                                        ),
                                      );
                                    }
                                  },
                                  child: PlayerCard(
                                    playerName: profile['name'] as String,
                                    backgroundColor:
                                        profile['backgroundColor'] as Color,
                                    imageProvider:
                                        profile['image']
                                            as ImageProvider<Object>,
                                    attributes:
                                        profile['attributes']
                                            as List<Map<String, Object>>,
                                    animateBars: isActive,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      // Navigation‑Buttons
                      /*Positioned(
                        left: buttonPosition,
                        child: IconButton(
                          onPressed: () => _goTo(_currentPage.round() - 1),
                          icon: Image.asset(
                            'assets/images/caroussel_button.png',
                            height: height / 8,
                          ), // Hier wird das Bild verwendet
                        ),
                      ),
                      Positioned(
                        right: buttonPosition,
                        child: IconButton(
                          onPressed: () => _goTo(_currentPage.round() + 1),
                          icon: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(
                              math.pi,
                            ), // Spiegelt das Bild horizontal
                            child: Image.asset(
                              'assets/images/caroussel_button.png',
                              height: height / 8,
                            ), // Hier wird das Bild verwendet
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
