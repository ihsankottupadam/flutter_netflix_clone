class TMDB {
  static const baseUrl = "https://api.themoviedb.org/3";
  static const Map endPoints = {
    'Trending Now': '/movie/popular',
    'Now Playing': '/movie/now_playing',
    'Top 10 Movies in India Today': '/trending/all/day',
    'Top 10 TV Shows': '/tv/popular',
    'Upcoming Movies': '/movie/upcoming',
    'Top Rated Movies': '/movie/top_rated',
    'Latest Movies': '/movie/latest'
  };
}
