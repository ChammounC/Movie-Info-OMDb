import 'package:flutter/material.dart';
import 'package:tradexa_movie/pages/details/general_info.dart';
import 'package:tradexa_movie/pages/details/ratings.dart';
 
import 'details/movie_info.dart';

class DetailPage extends StatelessWidget {
  DetailPage({required this.data});
  final Map<String,dynamic> data;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF17082A),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    foregroundDecoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Color(0xFF17082A),
                        Colors.black.withOpacity(0.0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    )), 
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.network(
                          data['poster']),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white30,
                            ),
                            child: InkWell(
                              child: Image.asset(
                                  'assets/icons/eva_arrow-ios-back-fill.png'),
                              onTap: () => Navigator.pop(context),
                            ),
                          ),
                          SizedBox(height: 250),
                          Text(
                            data['title'],
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            data['genre'],
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DummyButton(context, 'assets/icons/Vector 27.png'),
                  DummyButton(context, 'assets/icons/Path-1.png'),
                  DummyButton(context, 'assets/icons/Path.png'),
                ],
              ),
              RatingCard(data: data),
              MovieInfo(data:data),
              GeneralInfo(data:data),
            ],
          ),
        ),
      ),
    );
  }
}

Widget DummyButton(BuildContext context, String src) {
  return Container(
    height: MediaQuery.of(context).size.height / 10,
    width: MediaQuery.of(context).size.width / 5,
    decoration: BoxDecoration(
      color: Color(0xFF210F37),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(
        image: AssetImage(src),
        scale: 2.5,
      ),
    ),
  );
}
