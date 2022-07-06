import 'package:hive/hive.dart';
import 'package:netflix/models/movie.dart';

class WatchList {
  static Box<Movie> watchlistBox = Hive.box<Movie>('watchlist');
  static add(Movie movie) {
    watchlistBox.add(movie);
  }

  static remove(Movie movie) {
    for (Movie item in watchlistBox.values) {
      if (item.id == movie.id) {
        item.delete();
      }
    }
  }

  static bool contains(Movie movie) {
    for (Movie item in watchlistBox.values) {
      if (item.id == movie.id) {
        return true;
      }
    }
    return false;
  }
}
