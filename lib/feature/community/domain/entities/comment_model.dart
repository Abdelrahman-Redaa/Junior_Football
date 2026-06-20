import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  final String name;
  final String image;
  final String comment;

  const CommentModel({
    required this.name,
    required this.image,
    required this.comment,
  });

  @override
  List<Object?> get props => [name, image, comment];
}

final List<CommentModel> comments = [
  CommentModel(
    name: "Mohamed Mousa",
    image: "assets/images/mohamed.jpg",
    comment:
        "Absolutely Insane ! I Was On The Edge Of My Seat Watching This Live",
  ),
  CommentModel(
    name: "omar",
    image: "assets/images/omar.jpg",
    comment: "Unbelievable goal 😳",
  ),
  CommentModel(
    name: "Omar",
    image: "assets/images/mohamed.jpg",
    comment: "Best game ever ⚽",
  ),
];
