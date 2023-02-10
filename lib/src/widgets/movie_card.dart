// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'widgets.dart';

class MovieCard extends StatelessWidget {
  final bool isLoading;
  final MovieModel? data;

  const MovieCard({
    Key? key,
    this.isLoading = false,
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
        : VxBox()
            .rounded
            .sizePCT(context: context, widthPCT: 36, heightPCT: 24)
            .bgImage(
              DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(data!.posterPath!.isEmpty
                    ? "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png"
                    : "https://image.tmdb.org/t/p/w500/${data!.posterPath!}"),
              ),
            )
            .make();
  }
}
