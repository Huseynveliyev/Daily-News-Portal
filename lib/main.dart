import 'package:flutter/material.dart';
import 'package:news_app/data/news_services.dart';
import 'package:news_app/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily News',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Daily News'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//Warning!!!
class _MyHomePageState extends State<MyHomePage> {
  List<Articles> articles = [];

  @override
  void initState() {
    NewsService.getNews().then((value) {
      setState(() {
        articles = value!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
          child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Image.network(articles[index].urlToImage.toString()),
                      ListTile(
                          leading: Icon(Icons.arrow_drop_down_circle),
                          title: Text(articles[index].title.toString()),
                          subtitle: Text(articles[index].author.toString())),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(articles[index].description.toString()),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () async {
                              await launchUrl(Uri.parse(articles[index].url!));
                            },
                            child: Text('More info...'),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
