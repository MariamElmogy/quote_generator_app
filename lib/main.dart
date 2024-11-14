import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote_app/core/utils/service_locator.dart';
import 'package:quote_app/screens/home/data/repo/quote_repo_implement.dart';
import 'package:quote_app/screens/home/presentation/manager/cubit/quote_generator_cubit.dart';
import 'package:quote_app/screens/home/presentation/views/home_view.dart';

void main() {
  setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuoteGeneratorCubit(getIt.get<QuoteRepoImplement>())
        ..fetchQuoteGenerator(),
      child: const MaterialApp(
        title: 'Quote Generator',
        home: HomeView(),
      ),
    );
  }
}
