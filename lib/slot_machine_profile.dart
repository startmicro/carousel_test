import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlotMachineProfile extends StatefulWidget {
  final List<ImageProvider> images;
  final List<String> names;
  final Duration duration;
  final double height;

  const SlotMachineProfile({
    super.key,
    required this.images,
    required this.names,
    this.duration = const Duration(seconds: 2),
    this.height = 300,
  });

  @override
  State<SlotMachineProfile> createState() => _SlotMachineProfileState();
}

class _SlotMachineProfileState extends State<SlotMachineProfile>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  Timer? _timer;
  bool hasStopped = false;

  late AnimationController _fadeController;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);

    _startSlot();
  }

  void _startSlot() {
    const frameDuration = Duration(milliseconds: 100);

    _timer = Timer.periodic(frameDuration, (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % widget.images.length;
      });
    });

    Future.delayed(widget.duration, () {
      _timer?.cancel();
      final finalIndex = Random().nextInt(widget.images.length);

      setState(() {
        currentIndex = finalIndex;
        hasStopped = true;
      });

      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = widget.images[currentIndex];
    final name = widget.names[currentIndex];

    return AnimatedBuilder(
      animation: _fadeIn,
      builder: (context, child) {
        final double animationValue = hasStopped ? _fadeIn.value : 1.0;
        final double scale = 0.9 + 0.1 * animationValue;
        final double opacity = animationValue;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.scale(
              scale: scale,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFA055).withOpacity(0.8),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: widget.height,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationZ(0.05),
                    child: Opacity(
                      opacity: opacity,
                      child: Image(image: image),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Opacity(
              opacity: opacity,
              child: Text(
                name,
                style: GoogleFonts.luckiestGuy(
                  fontSize: 34,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
