part of 'widgets.dart';

class ListMovieLoader extends StatelessWidget {
  final bool isGridView;
  const ListMovieLoader({super.key, this.isGridView = false});

  @override
  Widget build(BuildContext context) {
    return isGridView
        ? GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: List.generate(
              6,
              (i) => const MovieCard(
                isLoading: true,
              ),
            ),
          ).px24().expand()
        : HStack(
            List.generate(
              4,
              (i) => const MovieCard(
                isLoading: true,
              ).pOnly(left: (i == 0) ? 24 : 16, right: (i == 4) ? 24 : 0),
            ),
          ).scrollHorizontal();
  }
}
