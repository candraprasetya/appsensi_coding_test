part of 'screens.dart';

class ShowAllScreen extends StatelessWidget {
  final List<MovieModel> movies = [];
  final ScrollController scrollController = ScrollController();
  ShowAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetIdCubit, SetIdState>(builder: (context, idState) {
      return RefreshIndicator(
        onRefresh: () async {
          movies.clear();
          BlocProvider.of<AllMovieBloc>(context)
              .add(FetchAllMovie(isNew: true, id: (idState as IdSet).id));
        },
        child: Scaffold(
          appBar: AppBar(
            title: 'Show All Movies'.text.make(),
          ),
          body: BlocConsumer<AllMovieBloc, AllMovieState>(
            listener: (context, state) {
              if (state is AllMovieIsLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Load more data...')));
              } else if (state is AllMovieIsSuccess && state.data.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No more movies')));
              } else if (state is AllMovieIsFailed) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
                context.read<AllMovieBloc>().isFetching = false;
              }
              return;
            },
            builder: (context, state) {
              if (state is AllMovieInitial ||
                  state is AllMovieIsLoading && movies.isEmpty) {
                return const CircularProgressIndicator().centered();
              } else if (state is AllMovieIsSuccess) {
                movies.addAll(state.data);
                context.read<AllMovieBloc>().isFetching = false;
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }
              return ListView.separated(
                controller: scrollController
                  ..addListener(() {
                    if (scrollController.offset ==
                            scrollController.position.maxScrollExtent &&
                        !context.read<AllMovieBloc>().isFetching) {
                      context.read<AllMovieBloc>()
                        ..isFetching = true
                        ..add(FetchAllMovie(id: (idState as IdSet).id));
                    }
                  }),
                itemBuilder: (context, index) {
                  return MovieCard(
                    data: movies[index],
                    isPoster: false,
                  ).px24();
                },
                separatorBuilder: (context, index) => 16.heightBox,
                itemCount: movies.length,
              );
            },
          ),
        ),
      );
    });
  }
}
