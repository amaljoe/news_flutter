import 'package:flutter/material.dart';
import 'package:news_flutter/components/news_item_widget.dart';
import 'package:news_flutter/utilities/news_item.dart';
import 'package:news_flutter/utilities/networking.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool showSpinner;
  List<NewsItem> newsItems = [];
  @override
  void initState() {
    super.initState();
    getNewsData();
  }

  void getNewsData() async {
    setState(() {
      showSpinner = true;
    });
    await NetworkHelper.getConversion(newsItems);
    print(newsItems[0].providerName);
    setState(() {
      showSpinner = false;
    });
    print('getting back also');
  }

  @override
  Widget build(BuildContext context) {
    if (showSpinner) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'News',
            style: TextStyle(
              fontFamily: 'roboto',
            ),
          ),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News',
          style: TextStyle(
            fontFamily: 'roboto',
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: newsItems.length,
          itemBuilder: (context, index) {
            return NewsItemWidget(newsItems[index]);
          },
        ),
      ),
    );
  }
}
