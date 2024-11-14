class QuoteModel {
  final String? quote;
  final String? author;
  final String? imageLink;
  final String? senderName;
  final String? senderLink;

  QuoteModel({
    required this.quote,
    required this.author,
    required this.imageLink,
    this.senderName,
    this.senderLink,
  });

  factory QuoteModel.fromJson(Map<dynamic, dynamic> json, {required String imageLink}) {
    return QuoteModel(
      quote: json["quoteText"],
      author: json["quoteAuthor"],
      imageLink: imageLink,
      senderName: json["senderName"],
      senderLink: json["senderLink"],
    );
  }
}
