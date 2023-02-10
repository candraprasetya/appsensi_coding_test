part of 'widgets.dart';

class DetailLoader extends StatelessWidget {
  const DetailLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return VStack([
      VxBox()
          .sizePCT(context: context, widthPCT: 100, heightPCT: 30)
          .color(colorName.neutral50)
          .rounded
          .make()
          .shimmer()
          .p24(),
      ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => VxBox()
                  .sizePCT(context: context, widthPCT: 60, heightPCT: 2)
                  .color(colorName.neutral50)
                  .rounded
                  .make()
                  .shimmer(),
              separatorBuilder: (context, index) => 16.heightBox,
              itemCount: 6)
          .px24()
    ]);
  }
}
