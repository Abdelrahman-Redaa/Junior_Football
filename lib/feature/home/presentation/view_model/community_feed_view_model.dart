import 'package:injectable/injectable.dart';
import 'package:junior_football/core/base_bloc/base_cubit.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/home/domain/entity/community_feed_entity.dart';
import 'package:junior_football/feature/home/domain/repo/home_repo.dart';
import 'package:junior_football/feature/home/presentation/view_model/community_feed_state.dart';

@injectable
class CommunityFeedViewModel extends BaseCubit<CommunityFeedState, CommunityFeedIntent, CommunityFeedEvent> {
  CommunityFeedViewModel(this._homeRepo)
      : super(CommunityFeedState(communityFeed: BaseState.init()));

  final HomeRepo _homeRepo;

  @override
  void doIntent(CommunityFeedIntent intent) {
    switch (intent) {
      case GetCommunityFeedIntent():
        _getCommunityFeed();
    }
  }

  Future<void> _getCommunityFeed() async {
    emit(state.copyWith(communityFeed: BaseState.loading()));
    final result = await _homeRepo.getCommunityFeed();
    switch (result) {
      case Success<List<CommunityFeedEntity>>():
        emit(state.copyWith(communityFeed: BaseState.loaded(result.data)));
      case Failure<List<CommunityFeedEntity>>():
        emit(state.copyWith(communityFeed: BaseState.error(result.errorMessage)));
    }
  }
}
