import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski/src/features/home_navigation/bloc/internet_listener_bloc.dart';
import 'package:taski/src/features/home_navigation/views/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I.get<InternetListenerBloc>()),
      ],
      child: const HomeView(),
    );
  }
}
