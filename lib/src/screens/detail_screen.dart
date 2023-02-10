part of 'screens.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Detail'.text.make(),
      ),
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is DetailIsLoading) {
            return const DetailLoader();
          }
          if (state is DetailIsSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<DetailBloc>(context)
                    .add(FetchDetailMovieById(state.data!.id!));
                BlocProvider.of<SimilarBloc>(context)
                    .add(FetchSimilarByMovieId(state.data!.id!));
              },
              child: VStack([
                _buildImage(context, state.data!),
                _buildMovieInformation(context, state.data!),
                _buildAnotherInformation(context, state.data!),
                _buildOverview(context, state.data!),
                _buildReview(context),
                _buildSimilarMovie(),
              ]).scrollVertical(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics())),
            );
          }
          return 0.heightBox;
        },
      ),
    );
  }

  Widget _buildReview(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        if (state is DetailIsSuccess) {
          return state.reviews!.isEmpty
              ? 'No Review'
                  .text
                  .color(colorName.neutral200)
                  .makeCentered()
                  .pSymmetric(v: 24)
              : VStack([
                  HStack([
                    'Reviews'.text.bold.make().expand(),
                    const Icon(Icons.arrow_forward_ios_rounded).onTap(() {
                      BlocProvider.of<ReviewBloc>(context).add(
                          FetchReviewByMovieId(state.data!.id!, isNew: true));
                      context.go('/detail/reviews');
                    })
                  ]).px24(),
                  8.heightBox,
                  ListView.separated(
                    separatorBuilder: (context, index) => 16.heightBox,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.reviews!.length,
                    itemBuilder: (context, index) => ReviewCard(
                      data: state.reviews![index],
                      isFull: false,
                    ),
                  )
                ]).pSymmetric(v: 24);
        }
        return 0.heightBox;
      },
    );
  }

  Widget _buildMovieInformation(BuildContext context, DetailMovieModel data) {
    return VStack(
      [
        data.title!.text.bold.xl.make(),
        data.tagline!.text.make(),
        16.heightBox,
        Wrap(
            children: data.genres!
                .map(
                  (e) => HStack(
                    [
                      e.name!.text.xs.color(colorName.neutral200).make(),
                      (data.genres!.indexOf(e) == data.genres!.length - 1)
                          ? 0.heightBox
                          : VxCircle(
                              backgroundColor: colorName.orang500,
                              radius: 6,
                            ).pSymmetric(h: 6)
                    ],
                  ),
                )
                .toList())
      ],
      axisSize: MainAxisSize.min,
      crossAlignment: CrossAxisAlignment.center,
    ).centered();
  }

  Widget _buildSimilarMovie() {
    return BlocBuilder<SimilarBloc, SimilarState>(
      builder: (context, state) {
        if (state is SimilarIsSuccess) {
          return MovieSection(
            title: "Similar Movie",
            isError: (state is SimilarIsFailed),
            isLoading: (state is SimilarInitial || state is SimilarIsLoading),
            data: state.data!,
          );
        }
        return 0.heightBox;
      },
    ).pOnly(bottom: 24);
  }

  Widget _buildOverview(BuildContext context, DetailMovieModel data) {
    return VStack([
      'Overview'.text.bold.make(),
      8.heightBox,
      data.overview!.text.xs.color(colorName.neutral300).make(),
    ]).px24();
  }

  Widget _buildAnotherInformation(BuildContext context, DetailMovieModel data) {
    return HStack([
      _boxContent('${data.popularity!.round()}', '\nPopularity'),
      16.widthBox,
      _boxContent('${data.voteAverage!}', '/10\nVote Average'),
      16.widthBox,
      _boxContent(data.status!, '\nStatus'),
    ]).p24();
  }

  Widget _buildImage(BuildContext context, DetailMovieModel data) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: ShaderMask(
        shaderCallback: (rect) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.transparent],
          ).createShader(
              Rect.fromLTRB(0, rect.height / 2, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Image.network(
          'https://image.tmdb.org/t/p/w500/${data.backdropPath}',
          height: context.percentHeight * 30,
          width: context.screenWidth,
          fit: BoxFit.cover,
        ),
      ),
    ).pSymmetric(v: 16, h: 24);
  }

  Widget _boxContent(String value, String title) {
    return VxBox(
      child:
          value.richText.bold.color(colorName.primary500).withTextSpanChildren(
        [title.textSpan.size(10).normal.color(colorName.neutral200).make()],
      ).make(),
    ).color(colorName.neutral50).p16.roundedSM.make().expand();
  }
}
