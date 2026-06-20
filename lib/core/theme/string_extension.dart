extension DateFormatter on String {
  String timeAgo() {
    try {
      final dateTime = DateTime.parse(this).toLocal();
      final now = DateTime.now();

      final difference = now.difference(dateTime);

      if (difference.inSeconds < 60) {
        return "${difference.inSeconds} seconds ago";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes} minutes ago";
      } else if (difference.inHours < 24) {
        return "${difference.inHours} hours ago";
      } else if (difference.inDays < 7) {
        return "${difference.inDays} days ago";
      } else if (difference.inDays < 30) {
        return "${(difference.inDays / 7).floor()} weeks ago";
      } else if (difference.inDays < 365) {
        return "${(difference.inDays / 30).floor()} months ago";
      } else {
        return "${(difference.inDays / 365).floor()} years ago";
      }
    } catch (e) {
      return this;
    }
  }
}