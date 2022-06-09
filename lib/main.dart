import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradexa_movie/pages/search_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        fontFamily: 'Montserrat',
      ),
      home: ChangeNotifierProvider(
        create: (_) => SearchResult(),
        child: SearchPage(),
      ),
    );
  } 
}

class SearchResult extends ChangeNotifier {
  bool searched = false;
  void toggleSearch() {
    searched = true;
    notifyListeners();
  }

  void failedSearch() {
    searched =  false;
    notifyListeners();
  }
}
