part of 'widgets.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel data;
  final bool isFull;
  const ReviewCard({Key? key, required this.data, this.isFull = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: VStack([
        HStack(
          [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(
                  "https://image.tmdb.org/t/p/w500/${data.authorDetails!.avatarPath!}"),
            ),
            16.widthBox,
            HStack(
              [
                VStack([
                  data.author!.text.medium.bold.make(),
                  (data.authorDetails!.rating!.isNaN)
                      ? 'Mantap'.text.make()
                      : VxBox(
                          child: HStack(
                            [
                              Icon(
                                Icons.star,
                                color: colorName.orang500,
                                size: context.percentWidth * 3,
                              ),
                              data.authorDetails!.rating!.text.xs.make()
                            ],
                            crossAlignment: CrossAxisAlignment.center,
                          ).pSymmetric(h: 4, v: 2),
                        )
                          .color(colorName.neutral0)
                          .roundedSM
                          .make()
                          .pOnly(right: 16),
                ]).expand(),
                Commons.formatDate(data.createdAt!).text.xs.make(),
              ],
              crossAlignment: CrossAxisAlignment.start,
            ).expand()
          ],
          crossAlignment: CrossAxisAlignment.start,
        ),
        16.heightBox,
        (isFull)
            ? data.content!.text.xs.make()
            : data.content!.text.maxLines(3).ellipsis.xs.make(),
      ]).p16(),
    ).color(colorName.neutral50).rounded.make().px24();
  }
}
