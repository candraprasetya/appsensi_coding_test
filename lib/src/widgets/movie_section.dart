part of 'widgets.dart';

class MovieSection extends StatelessWidget {
  final String? title;
  final Function()? event;
  final Function()? onTap;
  final List<MovieModel>? data;
  final bool? isLoading;
  final bool? isError;
  final String? message;
  final bool isGridView;

  const MovieSection(
      {super.key,
      this.title,
      this.event,
      this.onTap,
      this.data = const [],
      this.isLoading = false,
      this.isError = false,
      this.isGridView = false,
      this.message = ''});

  @override
  Widget build(BuildContext context) {
    return VStack([
      isGridView
          ? 0.heightBox
          : HStack([
              title!.text.bold.make().expand(),
              (onTap == null)
                  ? 0.heightBox
                  : const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ).onTap(onTap),
            ]).px24(),
      16.heightBox,
      isLoading!
          ? ListMovieLoader(
              isGridView: isGridView,
            )
          : isError!
              ? isGridView
                  ? 'No Movies Found'.text.makeCentered()
                  : NoData(
                      event: event,
                      message: message,
                    )
              : data!.isEmpty
                  ? 'No Movies Found'.text.makeCentered()
                  : isGridView
                      ? GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          children: data!
                              .map((e) => MovieCard(
                                    data: e,
                                  ))
                              .toList(),
                        ).px24().expand()
                      : HStack(
                          data!.map((e) {
                            int i = data!.indexOf(e);
                            return (i == data!.length - 1)
                                ? _buildShowMoreButton(context).pOnly(
                                    left: (i == 0) ? 24 : 16,
                                    right: (i == data!.length - 1) ? 24 : 0)
                                : MovieCard(data: e).pOnly(
                                    left: (i == 0) ? 24 : 16,
                                    right: (i == data!.length - 1) ? 24 : 0);
                          }).toList(),
                        ).scrollHorizontal(
                          physics: const BouncingScrollPhysics(),
                        )
    ]);
  }

  Widget _buildShowMoreButton(BuildContext context) {
    return VStack(
      [
        VxCircle(
          radius: context.percentWidth * 12,
          backgroundColor: colorName.neutral0,
          border: Border.all(color: colorName.neutral300),
          child: const Icon(
            Icons.arrow_forward_rounded,
            color: colorName.neutral500,
          ),
        ),
        8.heightBox,
        "Lihat Semua".text.xs.make()
      ],
      crossAlignment: CrossAxisAlignment.center,
    ).onTap(onTap);
  }
}
