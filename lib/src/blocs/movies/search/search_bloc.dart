import 'package:appsensi_coding_test/src/models/models.dart';
import 'package:appsensi_coding_test/src/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchMovieByKeyword>((event, emit) async {
      emit(SearchIsLoading());
      final result = await MovieService.searchByKeyword(event.keyword);
      emit(
        result.fold(
          (l) => SearchIsFailed(l),
          (r) {
            final data = List<MovieModel>.from(
                r.results!.map((x) => MovieModel.fromMap(x)));
            return SearchIsSuccess(data);
          },
        ),
      );
    });
    on<ResetSearch>((event, emit) async {
      emit(SearchInitial());
    });
  }
}
