class CommunityPostModel {
  final String name;
  final String time;
  final String userImage;

  final String? content;
  final String? postImage;
  final String? postVideo;

  final int likes;
  final int comments;

  CommunityPostModel({
    required this.name,
    required this.time,
    required this.userImage,
    this.content,
    this.postImage,
    this.postVideo,
    required this.likes,
    required this.comments,
  });
}


class CommunityDummyData {
  static List<CommunityPostModel> posts = [

    CommunityPostModel(
      name: "Mohamed Mousa",
      time: "2h",
      userImage: "assets/images/mohamed.jpg",
      content: "Don't stop dreaming🔥",
      postImage: "assets/images/mohamed.jpg",
      likes: 100,
      comments: 24,
    ),
    CommunityPostModel(
      name: "Mohamed Mousa",
      time: "2h",
      userImage: "assets/images/mohamed.jpg",
      content: "Don't stop dreaming🔥",
      postImage: "assets/images/omar.jpg",
      likes: 100,
      comments: 24,
    ),

    CommunityPostModel(
      name: "Omar Wheed",
      time: "2h",
      userImage: "assets/images/omar.jpg",
      content: " Incredible match last night! That  last-minute goal was pure magic. Who else is still buzzing from that  win? ⚽️🔥 #FootballFever #Champions",
      likes: 10,
      comments: 2,
    ),
    CommunityPostModel(
      name: "Omar Wheed",
      time: "2h",
      userImage: "assets/images/omar.jpg",
      content: " Incredible match last night! That  last-minute goal was pure magic. Who else is still buzzing from that  win? ⚽️🔥 #FootballFever #Champions",
      likes: 10,
      comments: 2,
    ),


  ];
}