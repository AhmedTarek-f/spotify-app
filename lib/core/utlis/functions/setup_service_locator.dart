import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<GetStorage>(GetStorage());
  getIt.registerSingleton<AudioPlayer>(AudioPlayer());
  getIt.registerSingleton<ImagePicker>(ImagePicker());
}