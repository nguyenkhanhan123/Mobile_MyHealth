class SearchReq {
  final String keyWord;
  final int page;
  final int limit;

  SearchReq({
    required this.keyWord,
    required this.page,
    required this.limit
  });

  Map<String, dynamic> toMap() {
    return {
      'keyWord': keyWord,
      'page': page,
      'limit': limit
    };
  }
}
