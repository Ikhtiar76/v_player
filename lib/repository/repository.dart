import 'package:v_player/model/model.dart';

import '../data/api/home_api.dart';

class VideoRepository {
  static Future<List<Result>> getUserData({required int pageno}) async {
    try {
      final response = await HomeApi.getUser(pageno);
      print('Raw Response Data: ${response.data}');

      final videos = Video.fromJson(response.data);
      print('Videos: $videos');

      final videoList = videos.results!;
      print('Video List: $videoList');
      return videoList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
