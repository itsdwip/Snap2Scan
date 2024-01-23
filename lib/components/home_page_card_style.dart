import 'package:flutter/material.dart';

class HomePageCard extends StatelessWidget {
  const HomePageCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final dynamic onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 200,
        width: 200,
        child: Card(
          color: Colors.blueGrey[900],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Icon(
                  icon,
                  color: Colors.blueGrey[50],
                  size: 50,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blueGrey[50],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
