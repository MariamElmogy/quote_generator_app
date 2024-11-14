import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_app/screens/home/presentation/manager/cubit/quote_generator_cubit.dart';
import 'package:quote_app/screens/home/presentation/views/widgets/quote_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuoteGeneratorCubit, QuoteGeneratorState>(
      builder: (context, state) {
        if (state is QuoteGeneratorSuccess) {
          return QuoteItem( data: state.quoteModel);
        } else if (state is QuoteGeneratorFailure) {
          return const Text('Failed to fetch quote');
        }
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      },
    );
  }
}