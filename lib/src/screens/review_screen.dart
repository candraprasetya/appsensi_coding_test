part of 'screens.dart';

class ReviewScreen extends StatelessWidget {
  final List<ReviewModel> reviews = [];
  final ScrollController scrollController = ScrollController();
  ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Review'.text.make(),
      ),
      body: BlocConsumer<ReviewBloc, ReviewState>(
        listener: (context, state) {
          if (state is ReviewIsLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Load more data...')));
          } else if (state is ReviewIsSuccess && state.data.isEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('No more reviews')));
          } else if (state is ReviewIsFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            context.read<ReviewBloc>().isFetching = false;
          }
          return;
        },
        builder: (context, state) {
          if (state is ReviewInitial ||
              state is ReviewIsLoading && reviews.isEmpty) {
            return const CircularProgressIndicator().centered();
          } else if (state is ReviewIsSuccess) {
            reviews.addAll(state.data);
            context.read<ReviewBloc>().isFetching = false;
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
          return BlocBuilder<DetailBloc, DetailState>(
            builder: (context, detailState) {
              if (detailState is DetailIsSuccess) {
                return ListView.separated(
                  controller: scrollController
                    ..addListener(() {
                      if (scrollController.offset ==
                              scrollController.position.maxScrollExtent &&
                          !context.read<ReviewBloc>().isFetching) {
                        context.read<ReviewBloc>()
                          ..isFetching = true
                          ..add(FetchReviewByMovieId(detailState.data!.id!));
                      }
                    }),
                  itemBuilder: (context, index) {
                    return ReviewCard(data: reviews[index]);
                  },
                  separatorBuilder: (context, index) => 16.heightBox,
                  itemCount: reviews.length,
                );
              }
              return 0.heightBox;
            },
          );
        },
      ),
    );
  }
}
