import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tradexa_movie/main.dart';
import 'detail_page.dart';

String apiKey = ; // Enter a valid OMDb API Key
String siteUrl = 'http://www.omdbapi.com/?apikey=$apiKey&';
Map<String, dynamic> data = {};

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xFF17082A),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/bg_bloop.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }
}

Widget _buildContent(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10).copyWith(bottom: 30),
          child: SearchBar(),
        ),
        ListView.builder(
          itemBuilder: Provider.of<SearchResult>(context).searched
              ? SuggestionList
              : _buildPreSearch,
          itemCount: 1,
          shrinkWrap: true,
        ),
      ],
    ),
  );
}

Widget _buildPreSearch(BuildContext context, int index) {
  return Container();
}

@override
Widget SuggestionList(BuildContext context, int index) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailPage(data: data),
        ),
      );
    },
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Color(0xFF17082A),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Ink.image(
                  image: NetworkImage(
                    data['poster'],
                  ),
                  alignment: Alignment(0, -0.55),
                  height: 210,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.7,
                        child: Container(
                          alignment: Alignment.topLeft,
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            const Text(' '),
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 18,
                            ),
                            Text(
                              ' ${data['imdbRating']} /10',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 12, 0, 0),
            child: Text(
              data['title'],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 12, 0, 0),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/Group 356.png',
                  height: 15,
                ),
                Text(
                  "   ${data['hours']} hours  ${data['mins']} minutes",
                  style: const TextStyle(
                    color: Color(0xFFF79E44),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _contentSearch = TextEditingController();

  Future<void> getData(String userString) async {
    var url = Uri.parse('${siteUrl}t=${userString}&plot=long');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['Response'].toString() == 'False') {
          Provider.of<SearchResult>(context, listen: false).failedSearch();
          _contentSearch.clear();
          _customDialog(
            context,
            'Could Not Find Anything',
            '',
          );
          return;
        }
        data = {
          'title': jsonData['Title'],
          'runtime': jsonData['Runtime'],
          'genre': jsonData['Genre'],
          'director': jsonData['Director'],
          'writer': jsonData['Writer'],
          'actors': jsonData['Actors'],
          'plot': jsonData['Plot'],
          'language': jsonData['Language'],
          'country': jsonData['Country'],
          'poster': jsonData['Poster'].toString(),
          'ratings': jsonData['Ratings'],
          'imdbRating': jsonData['imdbRating'],
          'year': jsonData['Year'],
        };
        String aStr = data['runtime'].replaceAll(new RegExp(r'[^0-9]'), '');
        int totalRuntime = int.parse(aStr);
        int hours = (totalRuntime / 60).toInt();
        int mins = totalRuntime - (hours * 60);
        data['hours'] = hours;
        data['mins'] = mins;
        String posterString =
            data['poster'].toString().replaceAll('300', '500');
        data['poster'] = posterString;
        List<String> directorList = data['director'].toString().split(',');
        List<String> actorList = data['actors'].toString().split(',');
        List<String> writerList = data['writer'].toString().split(',');
        data['director'] = directorList;
        data['writer'] = writerList;
        data['actors'] = actorList;
      } else if (response.statusCode == 400) {
        _customDialog(
          context,
          'No Internet Connection',
          'Please check your internet connection and try again.',
        );
      } else {
        _customDialog(
          context,
          'An Error occurred from the server side',
          'Please try again later.',
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    Provider.of<SearchResult>(context, listen: false).toggleSearch();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _contentSearch,
      onFieldSubmitted: (String userString) async {
        await getData(userString.toLowerCase());
      },
      keyboardType: TextInputType.text,
      style: const TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        hintStyle: const TextStyle(
          color: Colors.white30,
          fontStyle: FontStyle.italic,
        ),
        hintText: 'Search...',
        focusColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        fillColor: Colors.white24,
        prefixIcon: Image.asset(
          'assets/icons/Frame.png',
          scale: 2.5,
        ),
        suffixIcon: GestureDetector(
          onTap: _contentSearch.clear,
          child: Image.asset(
            'assets/icons/Group 220.png',
            scale: 2.5,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      ),
    );
  }
}

_customDialog(BuildContext context, String title, String content) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        title,
        style: TextStyle(fontSize: 18, fontFamily: 'Helvetica'),
      ),
      content: Text(
        content,
        style: TextStyle(fontSize: 14, fontFamily: 'Helvetica'),
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text(
            'OK',
          ),
          onPressed: Navigator.of(context).pop,
        ),
      ],
    ),
  );
}
