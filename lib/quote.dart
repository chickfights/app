class Quote {
  String id;
  String quote;

  Quote({this.id, this.quote});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'],
      quote: json['content']);
  }
}