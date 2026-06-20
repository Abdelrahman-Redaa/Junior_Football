class TwinPlayerEntity {
  final String? id;
  final String? twinPlayerName;
  final String? twinProfileImageUrl;
  final String? matchDescription;
  final int? matchPercentage;
  final List<MediaGalleryEntity>? mediaGallery;

  TwinPlayerEntity({
    this.id,
    this.twinPlayerName,
    this.twinProfileImageUrl,
    this.matchDescription,
    this.matchPercentage,
    this.mediaGallery,
  });

 
}

class MediaGalleryEntity {
  final String? title;
  final String? _url;
  final String? mediaType;

  MediaGalleryEntity({this.title, this.mediaType, String? url}) : _url = url;
  String get getVideoUrl => _url ?? '';
}
