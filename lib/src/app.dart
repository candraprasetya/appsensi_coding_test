import 'package:appsensi_coding_test/src/blocs/blocs.dart';
import 'package:appsensi_coding_test/src/cubits/cubits.dart';
import 'package:appsensi_coding_test/src/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SetIdCubit()),
        BlocProvider(create: (context) => NowPlayingBloc()),
        BlocProvider(create: (context) => AllMovieBloc()),
        BlocProvider(create: (context) => UpcomingBloc()),
        BlocProvider(create: (context) => PopularBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => DetailBloc()),
        BlocProvider(create: (context) => SimilarBloc()),
        BlocProvider(create: (context) => ReviewBloc()),
        BlocProvider(create: (context) => TrendingBloc()),
        BlocProvider(create: (context) => VideoBloc()),
      ],
      child: MaterialApp.router(
        title: "Moviiku",
        theme: myTheme,
        routerConfig: router,
      ),
    );
  }
}
