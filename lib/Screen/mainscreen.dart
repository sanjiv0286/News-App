import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> _newsList = [];

  @override
  void initState() {
    super.initState();
    // Fetch news when the widget is initialized
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    const apiKey =
        '0e4ab24dd47846a7bec59e5faf9631b9'; // Replace with your News API key
    const url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          _newsList = jsonData['articles'];
        });
      } else {
        // Handle error response
        stdout.write('Failed to fetch news: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors (e.g., network error)
      stdout.write('Error fetching news: $error');
    }
  }

// ignore_for_file: no_leading_underscores_for_local_identifiers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 10, 229),
        title: const Text(
          "MyNews",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Top Headlines",
                  style: TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                  ),
                ),
              ),
              _newsList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _newsList.length,
                        itemBuilder: (context, index) {
                          final article = _newsList[index];
                          return ListTile(
                            leading: ClipRRect(
                              // borderRadius:
                              //     const BorderRadius.all(Radius.circular(100)),
                              borderRadius: const BorderRadius.all(
                                  Radius.elliptical(20, 15)),
                              child: article['urlToImage'] != null
                                  ? Image.network(
                                      article['urlToImage'],
                                      width: 100,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: 80,
                                      height: 80,
                                      color: Colors
                                          .grey, // Placeholder color if no image available
                                    ),
                            ),
                            title: Text(
                              article['title'] ?? 'No Title',
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              article['description'] ?? 'No Description',
                              style: const TextStyle(fontSize: 15),
                              selectionColor: Colors.black,
                            ),
                            onTap: () {
                              // Handle article tap here (e.g., open a web page with the article)
                            },
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
