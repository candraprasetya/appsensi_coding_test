import 'package:appsensi_coding_test/src/models/models.dart';
import 'package:appsensi_coding_test/src/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailInitial()) {
    on<FetchDetailMovieById>((event, emit) async {
      emit(DetailIsLoading());
      final result = await MovieService.fetchMovieDetail(event.id);
      emit(
        result.fold(
          (l) => DetailIsFailed(l),
          (r) => DetailIsSuccess(r),
        ),
      );
    });
  }
}
