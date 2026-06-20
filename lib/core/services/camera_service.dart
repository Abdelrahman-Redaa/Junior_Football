import 'package:camera/camera.dart';
import 'package:gal/gal.dart';
import 'package:injectable/injectable.dart';

@injectable
class CameraService {
  Future<List<CameraDescription>> getCameras() async {
    return await availableCameras();
  }

  Future<bool> saveVideoToGallery(String path) async {
    try {
      final hasAccess = await Gal.hasAccess(toAlbum: false);
      if (!hasAccess) {
        final granted = await Gal.requestAccess(toAlbum: false);
        if (!granted) {
          return false;
        }
      }
      await Gal.putVideo(path);
      return true;
    } catch (e) {
      return false;
    }
  }
}
