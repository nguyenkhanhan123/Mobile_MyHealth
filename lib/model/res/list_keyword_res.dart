class ListKeywordRes {
  final String message;
  final List<String> similar;

  ListKeywordRes({required this.message,required this.similar});

  factory ListKeywordRes.fromJson(Map<String, dynamic> json) {
    return ListKeywordRes(
      message: json['message'] as String,
      similar: List<String>.from(json['similar']) ,
    );
  }
}
