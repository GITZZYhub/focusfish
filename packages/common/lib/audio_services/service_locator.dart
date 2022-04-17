import 'package:audio_service/audio_service.dart';
import 'package:common/audio_services/playlist_repository.dart';

import 'audio_handler.dart';
import 'package:getx/getx.dart';

import 'audio_manager.dart';

Future<void> setupServiceLocator() async {
  // audio_services
  Get.putAsync<AudioHandler>(() async => await initAudioService());

  Get.lazyPut<Playlist>(() => Playlist(), fenix: true);
  Get.lazyPut<AudioManager>(() => AudioManager(), fenix: true);
}
