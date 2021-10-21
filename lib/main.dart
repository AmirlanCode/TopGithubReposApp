import 'package:flutter/material.dart';
import 'package:github_provider/providers/git_http.dart';
import 'package:provider/provider.dart';

import 'pages/git_top_list.dart';

void main() => runApp(
      GitHubApp(),
    );

class GitHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => GitHttp(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            color: Colors.black26,
          ),
        ),
        home: GitTopList(),
      ),
    );
  }
}
