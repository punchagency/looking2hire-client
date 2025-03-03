import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_text.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 50,
                left: 36,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(height: 10),
                    CustomRobotoText(text: "Looking\nTo\nHire", textSize: 50, fontWeight: FontWeight.w700),
                  ],
                ),
              ),
              Positioned(
                bottom: 140,
                right: 36,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.arrow_forward),
                    SizedBox(height: 10),
                    CustomRobotoText(
                      text: "Looking\nTo\nWork",
                      textSize: 50,
                      fontWeight: FontWeight.w700,
                      alignText: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
