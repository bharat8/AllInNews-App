import 'package:all_in_news/widgets/BuildCards.dart';
import 'package:all_in_news/widgets/BuildList.dart';
import 'package:all_in_news/helpers/Category.dart';
import 'package:all_in_news/helpers/SearchNews.dart';
import '../../widgets/Drawer.dart';
import 'package:flutter/material.dart';
import '../models/news_item.dart';
import '../blocs/NewsBloc.dart';

class NewsList extends StatefulWidget {
  final String viewselected;
  NewsList({this.viewselected});
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final category = Category();
  final double categoryContainerHeight = 50;
  String selectedCategory = "General";
  int oldIndex = 0;
  int _pageNumber = 1;

  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;

  AsyncSnapshot<NewsModel> snap;
  List<Articles> articles = [];

  void _loadMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        _pageNumber += 1;
      });
    }
    newsBloc.fetchAllNews(selectedCategory, _pageNumber);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    newsBloc.fetchAllNews(selectedCategory, _pageNumber);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) _loadMore();
    });
    super.initState();
  }

  @override
  void dispose() {
    // newsBloc.connectionClose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color(0xfff2faff),
      drawer: DrawerSlider(),
      appBar: AppBar(
        title: Text(
          "AllInNews",
          textScaleFactor: 1,
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
                onTap: () {
                  showSearch(context: context, delegate: SearchBar());
                },
                child: Icon(Icons.search)),
          )
        ],
      ),
      body: Column(
        children: [
          _categories(),
          Container(
            height: mediaQuery.size.height -
                mediaQuery.padding.top -
                kToolbarHeight -
                categoryContainerHeight,
            child: StreamBuilder(
              stream: newsBloc.allNews,
              builder: (context, AsyncSnapshot<NewsModel> snapshot) {
                if (snapshot.hasData) {
                  return widget.viewselected == "0"
                      ? BuildCards(
                          scrollController: _scrollController,
                          snapshot: snapshot,
                        )
                      : BuildList(
                          scrollController: _scrollController,
                          snapshot: snapshot,
                        );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error.toString(),
                      textScaleFactor: 1,
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _categories() {
    return Container(
      padding: EdgeInsets.only(left: 5.0),
      height: categoryContainerHeight,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
          itemCount: category.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var text = Text(
              category.category(index),
              textScaleFactor: 1,
              style: TextStyle(color: Colors.white, fontSize: 17),
            );
            return Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    category.selectedCategory(index, oldIndex).then((value) {
                      oldIndex = index;
                      selectedCategory = value;
                    });
                  });
                  print(selectedCategory);
                },
                child: category.selected(index) == "true"
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            text,
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                            )
                          ],
                        ),
                      )
                    : Center(child: text),
              ),
            );
          }),
    );
  }
}
