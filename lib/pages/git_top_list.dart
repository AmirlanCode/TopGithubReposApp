import 'package:flutter/material.dart';
import 'package:github_provider/main.dart';
import 'package:github_provider/model/github.dart';
import 'package:github_provider/widgets/list_view_widget.dart';
import 'package:provider/provider.dart';

import 'package:github_provider/providers/git_http.dart';

class GitTopList extends StatefulWidget {
  @override
  State<GitTopList> createState() => _GitTopListState();
}

class _GitTopListState extends State<GitTopList> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {});
        Provider.of<GitHttp>(context, listen: false).pagination(true);
        Provider.of<GitHttp>(context, listen: false).parseGitList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Top 30 github repos for today',
        ),
      ),
      body: FutureBuilder<List<Items>>(
        future: Provider.of<GitHttp>(context, listen: false).parseGitList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: RefreshIndicator(
                onRefresh: () {
                  setState(() {});
                  return Provider.of<GitHttp>(context, listen: false)
                      .fetchHttp();
                },
                child: ListViewWidget(
                  list1: snapshot.data!,
                  scrollController: _scrollController,
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
