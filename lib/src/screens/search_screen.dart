part of 'screens.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;
  Timer? debounce;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<SearchBloc>(context).add(ResetSearch());
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(title: _buildTextField()),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return MovieSection(
              isGridView: true,
              isError: (state is SearchIsFailed),
              message: (state is SearchIsFailed) ? state.message : '',
              isLoading: (state is SearchIsLoading),
              data: (state is SearchIsSuccess) ? state.data : [],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: searchController,
      autofocus: true,
      decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type here to find your fav movie...'),
      onChanged: (value) {
        if (debounce?.isActive ?? false) debounce?.cancel();
        debounce = Timer(const Duration(milliseconds: 500), () {
          BlocProvider.of<SearchBloc>(context).add(SearchMovieByKeyword(value));
        });
      },
    );
  }
}
