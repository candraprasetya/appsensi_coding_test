import 'package:appsensi_coding_test/src/models/models.dart';
import 'package:appsensi_coding_test/src/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

part 'all_movie_event.dart';
part 'all_movie_state.dart';

class AllMovieBloc extends Bloc<AllMovieEvent, AllMovieState> {
  int page = 1;
  bool isFetching = false;
  AllMovieBloc() : super(AllMovieInitial()) {
    on<FetchAllMovie>((event, emit) async {
      late Either<String, ListResponseModel> result;
      if (event.isNew!) {
        page = 1;
      }
      emit(AllMovieIsLoading());
      switch (event.id) {
        case 1:
          result = await MovieService.fetchNowPlaying(page);
          break;
        case 2:
          result = await MovieService.fetchPopular(page);
          break;
        case 3:
          result = await MovieService.fetchUpcoming(page);
          break;
        case 4:
          result = await MovieService.fetchMovieByGenre(page, event.genreId!);
          break;
        default:
      }

      emit(
        result.fold(
          (l) => AllMovieIsFailed(l),
          (r) {
            final data = List<MovieModel>.from(
                r.results!.map((x) => MovieModel.fromMap(x)));
            page++;

            return AllMovieIsSuccess(data);
          },
        ),
      );
    });
  }
}
