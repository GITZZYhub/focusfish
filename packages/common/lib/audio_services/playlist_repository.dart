abstract class PlaylistRepository {
  Future<List<dynamic>> fetchInitialPlaylist(
      List<Map<String, String>> playList);

  Future<Map<String, String>> fetchAnotherSong(
      List<Map<String, String>> playList);
}

class Playlist extends PlaylistRepository {
  @override
  Future<List<Map<String, String>>> fetchInitialPlaylist(
      List<dynamic> playList) async {
    return List.generate(playList.length, (index) => _nextSong(playList));
  }

  @override
  Future<Map<String, String>> fetchAnotherSong(
      List<Map<String, String>> playList) async {
    return _nextSong(playList);
  }

  var _songIndex = 0;

  Map<String, String> _nextSong(List<dynamic> playList) {
    _songIndex = (_songIndex % playList.length) + 1;
    return {
      'id': playList[_songIndex - 1]['title'] ?? '',
      'title': playList[_songIndex - 1]['title'] ?? '',
      'album': 'FocusFish',
      'url': playList[_songIndex - 1]['url'] ?? '',
    };
  }
}
