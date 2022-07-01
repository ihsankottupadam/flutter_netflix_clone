import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:netflix/constants/apikey.dart';
import 'package:netflix/constants/tmdb.dart';
import 'package:netflix/models/movie.dart';

class MovieService {
  static Future<List<Movie>> fetchMovies({required String type}) async {
    List<Movie> moviesList = [];
    final String? endpoint = TMDB.endPoints[type];
    if (endpoint == null) {
      return [];
    }

    final String uriString =
        '${TMDB.baseUrl + endpoint}?api_key=${ApiKey.apiKey}';
    try {
      var response = await Dio().get(uriString);
      if (response.statusCode == 200) {
        return moviesFromJson(json.encode(response.data['results']));
      } else {
        print('yt call failed');
        throw response.statusCode ?? -1;
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  static Future<List> getSimilarMovies(int movieId) async {
    List<Movie> moviesList = [];
    final String uriString =
        '${TMDB.baseUrl}/movie/$movieId/similar?api_key=${ApiKey.apiKey}';

    try {
      var response = await Dio().get(uriString);
      if (response.statusCode == 200) {
        return moviesFromJson(json.encode(response.data['results']));
      } else {
        print('yt call failed');
        throw response.statusCode ?? -1;
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  static Future<List> searchMovies(String query) async {
    List<Movie> moviesList = [];
    final String uriString =
        '${TMDB.baseUrl}/search/movie?api_key=${ApiKey.apiKey}&query="$query"';
    try {
      var response = await Dio().get(uriString);
      if (response.statusCode == 200) {
        return moviesFromJson(json.encode(response.data['results']));
      } else {
        print('yt call failed');
        throw response.statusCode ?? -1;
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
