class Endpoint {
  static const String baseUrl = "https://test-ximit.mahfil.net/api";
  static const String videos = "/trending-video/1";

  // Timeout values
  static const Duration receiveTimeout =
      Duration(hours: 2, minutes: 3, seconds: 2);
  static const Duration connectionTimeout =
      Duration(hours: 2, minutes: 3, seconds: 2);
}
