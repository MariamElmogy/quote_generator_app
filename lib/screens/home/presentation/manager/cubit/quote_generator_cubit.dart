import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quote_app/screens/home/data/models/quote_model.dart';
import 'package:quote_app/screens/home/data/repo/quote_repo.dart';

part 'quote_generator_state.dart';

class QuoteGeneratorCubit extends Cubit<QuoteGeneratorState> {
  QuoteGeneratorCubit(this.quoteRepo) : super(QuoteGeneratorInitial());

  final QuoteRepo quoteRepo;

  Future<void> fetchQuoteGenerator() async {
    emit(QuoteGeneratorLoading());
    var result = await quoteRepo.fetchQuoteGenerator();
    result.fold((failure) {
      log('Fail ${failure.errMessage}');
      emit(QuoteGeneratorFailure(errorMessage: failure.errMessage));
    }, (quote) {
      log('Success');
      emit(QuoteGeneratorSuccess(quoteModel: quote));
    });
  }
}
