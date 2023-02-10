part of 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VStack(
        [
          _buildHeader(context),
          VStack(
            [
              _buildTodayTrending(),
              24.heightBox,
              _buildNowPlaying(),
              24.heightBox,
              _buildPopular(),
              24.heightBox,
              _buildUpcoming(),
              24.heightBox,
            ],
          )
              .scrollVertical(
                physics: const BouncingScrollPhysics(),
              )
              .expand(),
        ],
      ),
    );
  }

  Widget _buildTodayTrending() {
    return BlocBuilder<TrendingBloc, TrendingState>(
      builder: (context, state) {
        if (state is TrendingIsSuccess) {
          return VxSwiper(
              aspectRatio: 16 / 9,
              autoPlay: true,
              autoPlayCurve: Curves.easeInOut,
              enlargeCenterPage: true,
              items: state.data!
                  .map(
                    (e) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ZStack([
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.black, Colors.transparent],
                              ).createShader(Rect.fromLTRB(
                                  0, rect.height / 2, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500/${e.backdropPath}',
                              height: context.percentHeight * 30,
                              width: context.screenWidth,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        e.title!.text.bold.make().objectBottomRight().p24(),
                      ]),
                    ).pSymmetric(h: 4),
                  )
                  .toList());
        }
        return 0.heightBox;
      },
    );
  }

  Widget _buildNowPlaying() {
    return BlocBuilder<NowPlayingBloc, NowPlayingState>(
      builder: (context, state) {
        return MovieSection(
          title: "Now Playing",
          isError: (state is NowPlayingIsFailed),
          onTap: () {
            BlocProvider.of<SetIdCubit>(context).setId(1);
            BlocProvider.of<AllMovieBloc>(context)
                .add(FetchAllMovie(isNew: true, id: 1));
            context.go('/all');
          },
          message: (state is NowPlayingIsFailed) ? state.message : '',
          event: () => context.read<NowPlayingBloc>()
            ..isFetching = true
            ..add(
              FetchListNowPlaying(),
            ),
          isLoading:
              (state is NowPlayingInitial || state is NowPlayingIsLoading),
          data:
              (state is NowPlayingIsSuccess) ? state.data.take(5).toList() : [],
        );
      },
    );
  }

  Widget _buildUpcoming() {
    return BlocBuilder<UpcomingBloc, UpcomingState>(
      builder: (context, state) {
        return MovieSection(
          title: "Upcoming",
          isError: (state is UpcomingIsFailed),
          onTap: () {
            BlocProvider.of<SetIdCubit>(context).setId(3);
            BlocProvider.of<AllMovieBloc>(context)
                .add(FetchAllMovie(isNew: true, id: 3));

            context.go('/all');
          },
          message: (state is UpcomingIsFailed) ? state.message : '',
          event: () => context.read<UpcomingBloc>()
            ..isFetching = true
            ..add(
              FetchUpcoming(),
            ),
          isLoading: (state is UpcomingInitial || state is UpcomingIsLoading),
          data: (state is UpcomingIsSuccess) ? state.data.take(5).toList() : [],
        );
      },
    );
  }

  Widget _buildPopular() {
    return BlocBuilder<PopularBloc, PopularState>(
      builder: (context, state) {
        return MovieSection(
          title: "Popular",
          isError: (state is PopularIsFailed),
          message: (state is PopularIsFailed) ? state.message : '',
          onTap: () {
            BlocProvider.of<SetIdCubit>(context).setId(2);
            BlocProvider.of<AllMovieBloc>(context)
                .add(FetchAllMovie(isNew: true, id: 2));

            context.go('/all');
          },
          event: () => context.read<PopularBloc>()
            ..isFetching = true
            ..add(FetchPopular()),
          isLoading: (state is PopularInitial || state is PopularIsLoading),
          data: (state is PopularIsSuccess) ? state.data.take(5).toList() : [],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      child: VStack([
        HStack(
          [
            HStack([
              Image.asset(
                ImagePath.icon,
                scale: 12,
              ),
              4.widthBox,
              "Moviiku".text.make(),
            ]).expand(),
            const Icon(
              Icons.search,
              color: colorName.neutral500,
            ).onTap(() {
              context.go('/search');
            }),
          ],
          crossAlignment: CrossAxisAlignment.center,
        ),
        16.heightBox,
        const VxDivider(),
      ]).p24(),
    );
  }
}
