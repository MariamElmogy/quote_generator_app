import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:quote_app/core/errors/failures.dart';
import 'package:quote_app/core/utils/api_service.dart';
import 'package:quote_app/screens/home/data/models/quote_model.dart';
import 'package:quote_app/screens/home/data/repo/quote_repo.dart';

class QuoteRepoImplement implements QuoteRepo {
  QuoteRepoImplement(this.apiService);

  final ApiService apiService;

  @override
  Future<Either<Failure, QuoteModel>> fetchQuoteGenerator() async {
    try {
      var data = await apiService.getQuote();
      var imageLinkData = await apiService.getImage(name: data["quoteAuthor"]);
      log("imageData from different api ==> $imageLinkData");
      return right(QuoteModel.fromJson(data, imageLink: imageLinkData));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e));
    }
  }
}
