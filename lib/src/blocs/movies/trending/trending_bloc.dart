import 'package:appsensi_coding_test/src/models/models.dart';
import 'package:appsensi_coding_test/src/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'trending_event.dart';
part 'trending_state.dart';

class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  TrendingBloc() : super(TrendingInitial()) {
    on<FetchTrending>((event, emit) async {
      emit(TrendingIsLoading());
      final result = await MovieService.fetchTrending();
      emit(
        result.fold(
          (l) => TrendingIsFailed(l),
          (r) {
            final data = List<MovieModel>.from(
                r.results!.map((x) => MovieModel.fromMap(x)));
            return TrendingIsSuccess(data);
          },
        ),
      );
    });
  }
}
