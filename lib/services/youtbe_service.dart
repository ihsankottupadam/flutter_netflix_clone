import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:netflix/constants/apikey.dart';
import 'package:netflix/models/yt_search.dart';

class YouTubeService {
  static Future<String?> search(String query) async {
    final String uriString =
        'https://youtube.googleapis.com/youtube/v3/search?part=snippet&q=$query official trailer&key=${ApiKey.ytApiikey}';
    try {
      var response = await Dio().get(uriString);
      if (response.statusCode == 200) {
        print(response.statusCode);
        final List result = response.data['items'];

        return getFirstVideo(searchResultFromJson(json.encode(result)));
      } else {
        print('yt call failed');
        throw response.statusCode ?? -1;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static String? getFirstVideo(List searchResults) {
    for (SearchResult result in searchResults) {
      if (result.id.kind == 'youtube#video') {
        return result.id.videoId;
      }
    }
    return null;
  }
}
