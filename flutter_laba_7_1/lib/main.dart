import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90'));
  return compute(parsePhotos, response.body);
}

List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class Photo {
  final String ACTIVE_FROM;
  final String ID;
  final String TITLE;
  final String PREVIEW_TEXT;
  final String PREVIEW_PICTURE_SRC;
  final String DETAIL_PAGE_URL;
  final String DETAIL_TEXT;
  final String LAST_MODIFIED;

  const Photo({
    required this.ACTIVE_FROM,
    required this.ID,
    required this.TITLE,
    required this.PREVIEW_TEXT,
    required this.PREVIEW_PICTURE_SRC,
    required this.DETAIL_PAGE_URL,
    required this.DETAIL_TEXT,
    required this.LAST_MODIFIED,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      ACTIVE_FROM: json['ACTIVE_FROM'] as String,
      ID: json['ID'] as String,
      TITLE: json['TITLE'] as String,
      PREVIEW_TEXT: json['PREVIEW_TEXT'] as String,
      PREVIEW_PICTURE_SRC: json['PREVIEW_PICTURE_SRC'] as String,
      DETAIL_PAGE_URL: json['DETAIL_PAGE_URL'] as String,
      DETAIL_TEXT: json['DETAIL_TEXT'] as String,
      LAST_MODIFIED: json['LAST_MODIFIED'] as String,
    );
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Лента новостей КубГАУ';
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Ошибка запроса!'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({Key? key, required this.photos}) : super(key: key);
  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            height: 10,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.all(4),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(photos[index].PREVIEW_PICTURE_SRC),
                    Text('${photos[index].LAST_MODIFIED}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10.0),
                    Text('${photos[index].TITLE}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10.0),
                    Text('${photos[index].PREVIEW_TEXT}',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 12))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
