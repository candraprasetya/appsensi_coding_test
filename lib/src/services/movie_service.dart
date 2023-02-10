part of 'services.dart';

class MovieService {
  static Future<Either<String, ListResponseModel>> fetchNowPlaying(
      int page) async {
    try {
      final param = {
        'page': page,
        'language': 'en-US',
      };
      final result = await Api().get(
          param: param,
          "${Enpoints.nowPlaying}?api_key=${Commons.getApiKey()}");
      final listReponse = ListResponseModel.fromMap(result.data);

      return right(listReponse);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, ListResponseModel>> fetchUpcoming(
      int page) async {
    try {
      final param = {
        'page': page,
        'language': 'en-US',
      };
      final result = await Api().get(
          param: param, "${Enpoints.upcoming}?api_key=${Commons.getApiKey()}");
      final listReponse = ListResponseModel.fromMap(result.data);

      return right(listReponse);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, ListResponseModel>> fetchPopular(
      int page) async {
    try {
      final param = {
        'page': page,
        'language': 'en-US',
      };
      final result = await Api().get(
          param: param, "${Enpoints.popular}?api_key=${Commons.getApiKey()}");
      final listReponse = ListResponseModel.fromMap(result.data);

      return right(listReponse);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, DetailMovieModel>> fetchMovieDetail(
      int id) async {
    try {
      final param = {
        'language': 'en-US',
      };
      final result = await Api().get(
          param: param, "${Enpoints.movie}/$id?api_key=${Commons.getApiKey()}");
      final listReponse = DetailMovieModel.fromMap(result.data);

      return right(listReponse);
    } catch (e) {
      return left(e.toString());
    }
  }

  static Future<Either<String, ListResponseModel>> searchByKeyword(
      String keyword) async {
    try {
      final param = {
        'language': 'en-US',
      };
      final result = await Api().get(
          param: param,
          "${Enpoints.search}?api_key=${Commons.getApiKey()}&query=$keyword");
      final listReponse = ListResponseModel.fromMap(result.data);

      return right(listReponse);
    } catch (e) {
      return left(e.toString());
    }
  }
}