part of 'quote_generator_cubit.dart';

@immutable
abstract class QuoteGeneratorState {}

final class QuoteGeneratorInitial extends QuoteGeneratorState {}

final class QuoteGeneratorLoading extends QuoteGeneratorState {}

final class QuoteGeneratorSuccess extends QuoteGeneratorState {
  final QuoteModel quoteModel;
  QuoteGeneratorSuccess({required this.quoteModel});
}

final class QuoteGeneratorFailure extends QuoteGeneratorState {
  final String errorMessage;
  QuoteGeneratorFailure({required this.errorMessage});
}
