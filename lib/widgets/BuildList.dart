import 'package:AllinNews/src/models/news_item.dart';
import 'package:AllinNews/widgets/WebView.dart';
import 'package:flutter/material.dart';

class BuildList extends StatelessWidget {
  final ScrollController scrollController;
  final AsyncSnapshot<NewsModel> snapshot;
  BuildList({this.snapshot, this.scrollController});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data.articles.length,
      itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(
              left: 16.0, top: 16.0, bottom: 8.0, right: 16.0),
          child: LayoutBuilder(
            builder: (context, constraints) => GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) =>
                        WebView(url: snapshot.data.articles[index].url)),
              ),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    snapshot.data.articles[index].urlToImage != null
                        ? Container(
                            width: constraints.maxWidth * 0.27,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(snapshot
                                        .data.articles[index].urlToImage))),
                          )
                        : Container(
                            width: constraints.maxWidth * 0.27,
                            child: Text(
                              "No Image Available",
                              textScaleFactor: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                    Container(
                      width: constraints.maxWidth * 0.73 - 10,
                      // color: Colors.black,
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              snapshot.data.articles[index].source["name"] !=
                                      null
                                  ? Flexible(
                                      child: Chip(
                                          backgroundColor: Color(0xff6b80b0),
                                          label: Text(
                                            snapshot.data.articles[index]
                                                .source["name"],
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    )
                                  : Container(),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: snapshot
                                            .data.articles[index].postedTime !=
                                        null
                                    ? Text(
                                        "${snapshot.data.articles[index].postedTime}",
                                        textScaleFactor: 1,
                                        style: TextStyle(color: Colors.black45),
                                      )
                                    : Text(""),
                              ),
                            ],
                          ),
                          Flexible(
                            child: snapshot.data.articles[index].title != null
                                ? Text(
                                    snapshot.data.articles[index].title,
                                    maxLines: 2,
                                    textScaleFactor: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Container(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
