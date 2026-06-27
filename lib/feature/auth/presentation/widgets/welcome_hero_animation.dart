import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:junior_football/core/constants/app_assets.dart';

class WelcomeBallAnimation extends StatefulWidget {
  const WelcomeBallAnimation({super.key});

  @override
  State<WelcomeBallAnimation> createState() => _WelcomeBallAnimationState();
}

class _WelcomeBallAnimationState extends State<WelcomeBallAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _motionController;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _motionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _fade = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );
    _scale = Tween<double>(begin: 0.82, end: 1).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutBack),
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _motionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_entranceController, _motionController]),
      builder: (context, child) {
        final bounceOffset =
            math.sin(_motionController.value * math.pi) * -10.h;
        return Opacity(
          opacity: _fade.value,
          child: Transform.translate(
            offset: Offset(0, bounceOffset),
            child: Transform.scale(
              scale: _scale.value,
              child: Transform.rotate(
                angle: _motionController.value * math.pi * 0.08,
                child: child,
              ),
            ),
          ),
        );
      },
      child: Image.asset(AppAssets.ball, width: 88.w, height: 88.w),
    );
  }
}

class WelcomePlayerAnimation extends StatefulWidget {
  const WelcomePlayerAnimation({super.key});

  @override
  State<WelcomePlayerAnimation> createState() => _WelcomePlayerAnimationState();
}

class _WelcomePlayerAnimationState extends State<WelcomePlayerAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _motionController;
  late final Animation<double> _fade;
  late final Animation<double> _slide;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _motionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _fade = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );
    _slide = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _motionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_entranceController, _motionController]),
      builder: (context, child) {
        final runOffsetX = (_motionController.value * 2 - 1) * 22.w;
        final bobOffsetY = math.sin(_motionController.value * math.pi) * -5.h;
        final entranceOffsetX = (1 - _slide.value) * 36.w;

        return Opacity(
          opacity: _fade.value,
          child: Transform.translate(
            offset: Offset(runOffsetX + entranceOffsetX, bobOffsetY),
            child: child,
          ),
        );
      },
      child: Image.asset(
        AppAssets.player,
        width: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}
