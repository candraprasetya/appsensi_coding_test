// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final bool isLoading;
  final bool isPoster;
  final MovieModel? data;

  const MovieCard({
    Key? key,
    this.isLoading = false,
    this.isPoster = true,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? VxBox()
            .rounded
            .color(colorName.neutral50)
            .sizePCT(context: context, widthPCT: 36, heightPCT: 24)
            .make()
            .shimmer()
        : isPoster
            ? VxBox()
                .rounded
                .sizePCT(context: context, widthPCT: 36, heightPCT: 24)
                .bgImage(
                  DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(data!.posterPath!.isEmpty
                        ? "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png"
                        : "https://image.tmdb.org/t/p/w500/${(isPoster ? data!.posterPath! : data!.backdropPath!)}"),
                  ),
                )
                .make()
                .onTap(() {
                BlocProvider.of<DetailBloc>(context)
                    .add(FetchDetailMovieById(data!.id!));
                BlocProvider.of<SimilarBloc>(context)
                    .add(FetchSimilarByMovieId(data!.id!));
                BlocProvider.of<VideoBloc>(context)
                    .add(FetchVideoByMovieId(data!.id!));
                context.go('/detail');
              })
            : HStack(
                [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      data!.posterPath!.isEmpty
                          ? "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png"
                          : "https://image.tmdb.org/t/p/w500/${(isPoster ? data!.posterPath! : data!.backdropPath!)}",
                      fit: BoxFit.cover,
                      width: context.percentWidth * 40,
                      height: context.percentHeight * 16,
                    ),
                  ),
                  16.widthBox,
                  VStack([
                    data!.title!.text.bold.make(),
                    data!.overview!.text
                        .maxLines(2)
                        .xs
                        .color(colorName.neutral300)
                        .ellipsis
                        .make(),
                    16.heightBox,
                    VxBox(
                      child: HStack(
                        [
                          Icon(
                            Icons.star,
                            color: colorName.orang500,
                            size: context.percentWidth * 3,
                          ),
                          4.widthBox,
                          "${data!.voteAverage!}"
                              .richText
                              .bold
                              .color(colorName.primary500)
                              .withTextSpanChildren(
                            [
                              '/10'
                                  .textSpan
                                  .size(10)
                                  .normal
                                  .color(colorName.neutral200)
                                  .make()
                            ],
                          ).make(),
                        ],
                        crossAlignment: CrossAxisAlignment.center,
                      ).pSymmetric(h: 4, v: 2),
                    )
                        .color(colorName.neutral0)
                        .roundedSM
                        .make()
                        .pOnly(right: 16),
                  ]).expand()
                ],
                crossAlignment: CrossAxisAlignment.start,
              ).onTap(() {
                BlocProvider.of<DetailBloc>(context)
                    .add(FetchDetailMovieById(data!.id!));
                BlocProvider.of<SimilarBloc>(context)
                    .add(FetchSimilarByMovieId(data!.id!));
                context.go('/detail');
              });
  }
}
