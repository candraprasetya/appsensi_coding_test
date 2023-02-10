import 'package:appsensi_coding_test/src/models/models.dart';
import 'package:appsensi_coding_test/src/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  late DetailMovieModel movie;
  late List<ReviewModel> reviews;
  DetailBloc() : super(DetailInitial()) {
    on<FetchDetailMovieById>((event, emit) async {
      emit(DetailIsLoading());
      final result = await MovieService.fetchMovieDetail(event.id);
      final resultReviews = await MovieService.fetchReview(event.id, 1);

      result.fold(
        (l) => emit(DetailIsFailed(l)),
        (r) {
          movie = r;
        },
      );
      resultReviews.fold(
        (l) => emit(DetailIsFailed(l)),
        (r) {
          reviews = List<ReviewModel>.from(
              r.results!.map((x) => ReviewModel.fromMap(x)));
        },
      );
      emit(DetailIsSuccess(
          data: movie,
          reviews: (reviews.length > 3) ? reviews.take(3).toList() : reviews));
    });
  }
}
