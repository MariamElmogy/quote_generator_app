import 'package:dio/dio.dart';

class ApiService {
  final quoteBaseUrl = "http://api.forismatic.com/api/1.0/";
  final imageBaseUrl = "https://en.wikipedia.org/w/api.php";
  final Dio dio;

  ApiService(this.dio);

  Future<Map<String, dynamic>> getQuote() async {
    try {
      final response = await dio.get(
        quoteBaseUrl,
        queryParameters: {
          "method": "getQuote",
          "format": "json",
          "lang": "en",
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch data from API: ${e.message}');
    }
  }

  Future<String> getImage({required String name}) async {
    try {
      final response = await dio.get(
        "$imageBaseUrl/?action=query&generator=search&gsrlimit=1&prop=pageimages%7Cextracts&pithumbsize=400&gsrsearch=$name&format=json",
      );

      if (response.statusCode == 200) {
        var res = response.data["query"]["pages"];
        res = res[res.keys.first];
        return res["thumbnail"]["source"];
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } on DioException catch (e) {
      throw Exception('Failed to fetch data from API: ${e.message}');
    }
  }
}
