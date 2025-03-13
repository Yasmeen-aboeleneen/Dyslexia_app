import 'package:dyslexia_app/Core/Constants/colors.dart';
import 'package:dyslexia_app/Views/OnBoarding/onboarding_screen.dart';
import 'package:dyslexia_app/Views/Splash/Widgets/custom_splash_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
static const routeName = "splash";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
    flutterTts = FlutterTts();
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await flutterTts.setLanguage("ar-SA");
  }

  Future<void> _playButtonSound() async {
    await flutterTts.speak("ابدأ");
    await Future.delayed(Duration(seconds: 3));
    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kPrimary2,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: h * .56,
              width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(250),
                  bottomRight: Radius.circular(250),
                ),
                color: kveryWhite,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/logo.jpeg'),
                ),
              ),
            ),
          ),
          Positioned(
            top: h * .68,
            left: w * .2,
            right: w * .2,
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: Duration(seconds: 2),
                style: GoogleFonts.cairo(
                  // ignore: deprecated_member_use
                  color: kveryWhite.withOpacity(_animation.value),
                  fontWeight: FontWeight.bold,
                  fontSize: w * .09 * _animation.value,
                ),
                child: Text("عسر القراءة"),
              ),
            ),
          ),
          Positioned(
            left: w * .25,
            right: w * .25,
            bottom: h * .08,
            child: CustomSplashButton(
              text: "ابدأ",
              onTap: () {
                _playButtonSound();
              },
            ),
          ),
        ],
      ),
    );
  }
}
