import 'package:appsensi_coding_test/src/models/models.dart';
import 'package:appsensi_coding_test/src/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  bool isFetching = false;

  PopularBloc() : super(PopularInitial()) {
    on<FetchPopular>(
      (event, emit) async {
        emit(PopularIsLoading());
        final result = await MovieService.fetchPopular(1);
        emit(
          result.fold(
            (l) => PopularIsFailed(l),
            (r) {
              final data = List<MovieModel>.from(
                  r.results!.map((x) => MovieModel.fromMap(x)));
              return PopularIsSuccess(data);
            },
          ),
        );
      },
    );
  }
}
