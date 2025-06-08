import 'package:carousel_test/PlayerCarousel/player_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Nur Landscape erlauben
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        {'label': 'Speed', 'value': 95},
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
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
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
                      final opacity = 1 - difference * 0.4;

                      return Opacity(
                        opacity: opacity.clamp(0.6, 1.0),
                        child: Center(
                          child: PlayerCard(
                            playerName: profile['name'] as String,
                            backgroundColor:
                                profile['backgroundColor'] as Color,
                            imageProvider:
                                profile['image'] as ImageProvider<Object>,
                            attributes:
                                profile['attributes']
                                    as List<Map<String, Object>>,
                          ),
                        ),
                      );
                    },
                  ),
                  // Navigation‑Buttons
                  Positioned(
                    left: 120,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_left,
                        size: 160,
                        color: Color(0xFFDFAA44),
                      ),
                      onPressed: () => _goTo(_currentPage.round() - 1),
                    ),
                  ),
                  Positioned(
                    right: 120,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_right,
                        size: 160,
                        color: Color(0xFFDFAA44),
                      ),
                      onPressed: () => _goTo(_currentPage.round() + 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
