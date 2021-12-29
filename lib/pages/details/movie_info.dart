import 'package:flutter/cupertino.dart';
import 'package:tradexa_movie/common_widgets/custom_card.dart';

class MovieInfo extends StatelessWidget {
  MovieInfo({required this.data});
  final Map<String,dynamic> data;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      column1: _buildRow('assets/icons/Group 357.png', data['year']),
      column2: _buildRow('assets/icons/Vector.png', data['country']),
      column3: _buildRow('assets/icons/Group 356.png', data['runtime']),
      column4: _buildRow('assets/icons/Group 358.png', data['language']),
    );
  }
}

_buildRow(String src, String text) {
  return Row(
    children: [
      Flexible(
        flex: 1,
        child: Container(
          height: 25,
          child: Image.asset(src),
        ),
      ),
      const Spacer(
        flex: 1,
      ),
      Flexible(
          flex: 8,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFFFFFFF),
            ),
          )),
    ],
  );
}
