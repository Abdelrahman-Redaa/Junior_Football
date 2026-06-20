import 'package:equatable/equatable.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/feature/home/domain/entity/community_feed_entity.dart';

class CommunityFeedState extends Equatable {
  final BaseState<List<CommunityFeedEntity>> communityFeed;

  const CommunityFeedState({
    required this.communityFeed,
  });

  CommunityFeedState copyWith({
    BaseState<List<CommunityFeedEntity>>? communityFeed,
  }) {
    return CommunityFeedState(
      communityFeed: communityFeed ?? this.communityFeed,
    );
  }

  @override
  List<Object?> get props => [communityFeed];
}

sealed class CommunityFeedEvent {}

sealed class CommunityFeedIntent {}

class GetCommunityFeedIntent extends CommunityFeedIntent {}
