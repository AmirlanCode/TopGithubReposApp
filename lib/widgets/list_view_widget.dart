import 'package:flutter/material.dart';
import 'package:github_provider/providers/git_http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListViewWidget extends StatelessWidget {
  final List list1;
  final ScrollController scrollController;
  const ListViewWidget(
      {Key? key, required this.list1, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemBuilder: (context, index) {
        var format = DateFormat.yMd();
        final date = list1[index].pushedAt;
        final dateString = format.format(date);
        if (index == list1.length - 1) {
          return Stack(
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }
        return Card(
          elevation: 5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100.0,
                height: 100.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/gitmark.png'),
                    image: NetworkImage(list1[index].owner.avatarUrl),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Text(
                        list1[index].name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    SizedBox(
                      height: 25,
                      width: 210,
                      child: Text(
                        list1[index].description != null
                            ? list1[index].description.toString()
                            : 'no description',
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                      ),
                    ),
                    Row(
                      children: [
                        Text('⭐ ${list1[index].stargazersCount.toString()}'),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text('⚡ ${list1[index].openIssuesCount.toString()}'),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${dateString.toString()}',
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
      itemCount: list1.length,
    );
  }
}
