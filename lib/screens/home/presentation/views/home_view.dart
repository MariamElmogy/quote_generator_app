import 'package:flutter/material.dart';
import 'package:quote_app/screens/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: const HomeViewBody(),
    );
  }
}
