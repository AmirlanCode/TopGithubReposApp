class Github {
  int totalCount;
  bool incomplete_results;
  List<Items> items;

  Github({
    required this.totalCount,
    required this.incomplete_results,
    required this.items,
  });

  factory Github.fromJson(Map<String, dynamic> json) {
    return Github(
        totalCount: json['totalCount'],
        incomplete_results: json['incomplete_results'],
        items: json['items']);
  }
}

class Items {
  int id;
  String name;
  Owner owner;
  String? description;
  DateTime pushedAt;
  int stargazersCount;
  int openIssuesCount;

  Items({
    required this.id,
    required this.name,
    required this.owner,
    this.description = '',
    required this.pushedAt,
    required this.stargazersCount,
    required this.openIssuesCount,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      name: json['name'],
      owner: Owner.fromJson(json["owner"]),
      description: json['description'],
      pushedAt: DateTime.parse(json["pushed_at"]),
      stargazersCount: json['stargazers_count'],
      openIssuesCount: json["open_issues_count"],
    );
  }
}

class Owner {
  String avatarUrl;

  Owner({required this.avatarUrl});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(avatarUrl: json['avatar_url']);
  }
}
