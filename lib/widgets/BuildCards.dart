import 'package:AllinNews/src/models/news_item.dart';
import 'package:AllinNews/widgets/WebView.dart';
import 'package:flutter/material.dart';

class BuildCards extends StatelessWidget {
  final ScrollController scrollController;
  final AsyncSnapshot<NewsModel> snapshot;
  BuildCards({this.snapshot, this.scrollController});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      itemCount: snapshot.data.articles.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
            onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) =>
                          WebView(url: snapshot.data.articles[index].url)),
                ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      snapshot.data.articles[index].urlToImage != null
                          ? Container(
                              height: constraints.maxHeight * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      snapshot.data.articles[index].urlToImage,
                                    ),
                                    fit: BoxFit.cover,
                                  )),
                            )
                          : Container(
                              height: constraints.maxHeight * 0.6,
                              child: Center(
                                child: Text(
                                  "No Image Available",
                                  textScaleFactor: 1,
                                ),
                              )),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 8, right: 8),
                              child: snapshot.data.articles[index].title != null
                                  ? Text(
                                      snapshot.data.articles[index].title,
                                      maxLines: 2,
                                      textScaleFactor: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Text(""),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 4.0, left: 8, right: 8),
                              child: snapshot.data.articles[index].postedTime !=
                                      null
                                  ? Text(
                                      "${snapshot.data.articles[index].postedTime}",
                                      overflow: TextOverflow.ellipsis,
                                      textScaleFactor: 1,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(""),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
