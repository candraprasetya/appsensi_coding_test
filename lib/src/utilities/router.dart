part of 'utilities.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        BlocProvider.of<NowPlayingBloc>(context).add(FetchListNowPlaying());
        BlocProvider.of<UpcomingBloc>(context).add(FetchUpcoming());
        BlocProvider.of<PopularBloc>(context).add(FetchPopular());
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'search',
          builder: (BuildContext context, GoRouterState state) {
            return const SearchScreen();
          },
        ),
        GoRoute(
          path: 'all',
          builder: (BuildContext context, GoRouterState state) {
            return ShowAllScreen();
          },
        ),
      ],
    ),
  ],
);
