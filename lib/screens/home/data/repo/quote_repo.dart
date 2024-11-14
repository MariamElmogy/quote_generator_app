import 'package:dartz/dartz.dart';
import 'package:quote_app/core/errors/failures.dart';
import 'package:quote_app/screens/home/data/models/quote_model.dart';

abstract class QuoteRepo {
  Future<Either<Failure, QuoteModel>> fetchQuoteGenerator();
}
