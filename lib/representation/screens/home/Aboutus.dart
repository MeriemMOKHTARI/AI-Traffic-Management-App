import 'package:flutter/material.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/static/colors.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Text('About Us Screen'),
      ),
    );
  }
}

