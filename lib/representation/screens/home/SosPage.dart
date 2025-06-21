import 'dart:async';
import 'package:flutter/material.dart';

class SosScreen extends StatefulWidget {
  const SosScreen({Key? key}) : super(key: key);
  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  bool _isPressed = false;
  int _secondsPressed = 0;
  late Timer _timer;

  void _startTimer(BuildContext context) {
    setState(() {
      _isPressed = true;
      _secondsPressed = 0;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsPressed++;
      });

      if (_secondsPressed >= 3) {
        _timer.cancel();
        setState(() {
          _isPressed = false;
          _secondsPressed = 0;
        });
       
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'De l\'aide sera bientôt envoyée à votre localisation',
              style: TextStyle(fontSize: 16),
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          ),
        );

        // Add a slight delay before navigating back
        Timer(const Duration(milliseconds: 500), () {
          Navigator.of(context).pop();
        });
      }
    });
  }

  void _cancelTimer() {
    _timer.cancel();
    setState(() {
      _isPressed = false;
      _secondsPressed = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTapDown: (_) => _startTimer(context),
              onTapUp: (_) => _cancelTimer(),
              onTapCancel: () => _cancelTimer(),
              child: Image.asset(
                'assets/images/soss.png',
                width: 250,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_isPressed) {
      _timer.cancel();
    }
    super.dispose();
  }
}