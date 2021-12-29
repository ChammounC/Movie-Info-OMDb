import 'package:flutter/material.dart';
import 'package:tradexa_movie/common_widgets/custom_card.dart';

class GeneralInfo extends StatelessWidget {
  GeneralInfo({required this.data});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      column1: _buildPlot('Plot', data['plot']),
      column2: _buildInfoCard('Director', data['director']),
      column3: _buildInfoCard('Actors', data['actors']),
      column4: _buildInfoCard('Writer', data['writer']),
    );
  }
}

_buildPlot(String title, String cardText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 30,
          color: Color(0xFFFFFFFF),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Text(
        '"$cardText"',
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xFFFFFFFF),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
    ],
  );
}

_buildInfoCard(String title, List<String> names) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 25,
          color: Color(0xFFFFFFFF),
        ),
      ),
      buildCard(names: names),
      const SizedBox(height: 20),
    ],
  );
}

class buildCard extends StatelessWidget {
  buildCard({required this.names});
  final List<String> names;
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: names.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 3),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  names[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFC59BBB),
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
