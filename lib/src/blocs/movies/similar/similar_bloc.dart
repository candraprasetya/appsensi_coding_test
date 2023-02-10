import 'package:appsensi_coding_test/src/models/models.dart';
import 'package:appsensi_coding_test/src/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'similar_event.dart';
part 'similar_state.dart';

class SimilarBloc extends Bloc<SimilarEvent, SimilarState> {
  SimilarBloc() : super(SimilarInitial()) {
    on<FetchSimilarByMovieId>((event, emit) async {
      emit(SimilarIsLoading());
      final result = await MovieService.fetchSimilarMovie(event.id);
      emit(
        result.fold(
          (l) => SimilarIsFailed(l),
          (r) {
            final data = List<MovieModel>.from(
                r.results!.map((x) => MovieModel.fromMap(x)));

            return SimilarIsSuccess(data);
          },
        ),
      );
    });
  }
}
