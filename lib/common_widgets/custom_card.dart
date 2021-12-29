import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    required this.column1,
    required this.column2,
    required this.column3,
    required this.column4,
  });
  final Widget column1;
  final Widget column2;
  final Widget column3;
  final Widget column4;


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        color: Color(0xFF210F37),
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              column1,
              SizedBox(height: 15,),
              column2,
              SizedBox(height: 15,),
              column3,
              SizedBox(height: 15,),
              column4,
            ],
          ),
        ),
      ),
    );
  }
}
