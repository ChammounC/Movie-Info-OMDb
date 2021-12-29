import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:tradexa_movie/common_widgets/custom_card.dart';

class RatingCard extends StatelessWidget {
  RatingCard({required this.data});
  final Map<String,dynamic> data;

  @override
  Widget build(BuildContext context) {
  double rating=(double.parse(data['imdbRating']))/2;
    return CustomCard(
      column1: Row(
        children: [
          SmoothStarRating(
              allowHalfRating: true,
              starCount: 5,
              rating: rating,
              size: 25.0,
              color: const Color(0xFFF79E44),
              borderColor:const Color(0xFFF79E44),
              spacing: 0.0),
          const Spacer(),
          Text(
            data['imdbRating'],
            style:const TextStyle(
              fontSize: 25,
              color: Color(0xFFF79E44),
            ),
          ),
        ],
      ),
      column2: _buildRow(data['ratings'][0]['Source'], data['ratings'][0]['Value']),
      column3: _buildRow(data['ratings'][1]['Source'], data['ratings'][1]['Value']),
      column4: _buildRow(data['ratings'][2]['Source'], data['ratings'][2]['Value']),
    );
  }
}

_buildRow(String text, String rating) {
  return Row(
    children: [
      Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
      const Spacer(),
      Text(
        rating,
        textAlign: TextAlign.end,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    ],
  );
}
