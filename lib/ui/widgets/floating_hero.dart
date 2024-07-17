import 'package:flutter/material.dart';

class UpDownAnimation extends StatefulWidget {
  const UpDownAnimation({super.key});

  @override
  UpDownAnimationState createState() => UpDownAnimationState();
}

class UpDownAnimationState extends State<UpDownAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: const Offset(0, 0.5),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Container(
        height: 200,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logo-removebg.png"),
          ),
        ),
      ),
    );
  }
}
