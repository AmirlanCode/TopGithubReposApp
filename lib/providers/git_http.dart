import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'package:github_provider/model/github.dart';
import 'package:intl/intl.dart';

class GitHttp extends ChangeNotifier {
  //лист может понадобится

  List<Items> items = [];
  int _page = 30;
  Future<String> fetchHttp() async {
    final date = DateTime.now().subtract(
      Duration(days: 1),
    );
    String formatted = DateFormat('yyyy-MM-dd').format(date);
    print(formatted);
    final _url =
        'https://api.github.com/search/repositories?q=created:>$formatted&sort=stars&order=desc&per_page=$_page';

    final response = await get(Uri.parse(_url));
    final body = response.body;

    return body;
  }

  Future<List<Items>> parseGitList() async {
    final gotList = await fetchHttp();
    final castedList = jsonDecode(gotList);
    final casted = castedList['items'].cast<Map<String, dynamic>>();
    List<Items> parsedList =
        casted.map<Items>((items) => Items.fromJson(items)).toList();
    items.addAll(parsedList);
    return parsedList;
  }

  Future<void> pagination(bool pag) async {
    if (!pag) {
      _page += 0;
    }
    _page += 10;
  }
}
