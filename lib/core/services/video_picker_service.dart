import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class VideoPickerService {
  final _picker = ImagePicker();
  // Pick a video.
  Future<XFile?> pickVideo() async {
    final XFile? galleryVideo = await _picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (galleryVideo != null) {
      return galleryVideo;
    }
    return null;
  }
}
