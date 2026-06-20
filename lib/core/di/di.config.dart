// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:talker_dio_logger/talker_dio_logger.dart' as _i52;

import '../../feature/ai/data/datasource/ai_data_soucre_impl.dart' as _i525;
import '../../feature/ai/data/datasource/ai_data_source.dart' as _i797;
import '../../feature/ai/data/repo/ai_repo_impl.dart' as _i472;
import '../../feature/ai/domain/repo/ai_repo.dart' as _i914;
import '../../feature/ai/presentation/view_model/ai_view_model.dart' as _i84;
import '../../feature/ai/presentation/view_model/chat_view_model.dart' as _i402;
import '../../feature/auth/data/data_source/auth_data_source.dart' as _i868;
import '../../feature/auth/data/data_source/auth_data_source_impl.dart'
    as _i364;
import '../../feature/auth/data/repo/auth_repo_impl.dart' as _i945;
import '../../feature/auth/domain/repo/auth_repo.dart' as _i1021;
import '../../feature/auth/presentation/view_model/auth_view_model.dart'
    as _i117;
import '../../feature/community/data/datasource/community_datasource.dart'
    as _i282;
import '../../feature/community/data/datasource/community_datasource_impl.dart'
    as _i82;
import '../../feature/community/data/repo/community_repo_impl.dart' as _i919;
import '../../feature/community/domain/repo/community_repo.dart' as _i480;
import '../../feature/community/presentation/view_model/community_view_model.dart'
    as _i769;
import '../../feature/home/data/datasource/home_data_source.dart' as _i238;
import '../../feature/home/data/datasource/home_data_source_impl.dart' as _i83;
import '../../feature/home/data/repo/home_repo_impl.dart' as _i909;
import '../../feature/home/domain/repo/home_repo.dart' as _i518;
import '../../feature/home/presentation/view_model/analysis_view_model.dart'
    as _i416;
import '../../feature/home/presentation/view_model/community_feed_view_model.dart'
    as _i847;
import '../../feature/home/presentation/view_model/home_view_model.dart'
    as _i60;
import '../../feature/home/presentation/view_model/video_record_view_model.dart'
    as _i502;
import '../../feature/profile/data/data_source/profile_data_source.dart'
    as _i80;
import '../../feature/profile/data/data_source/profile_data_source_impl.dart'
    as _i295;
import '../../feature/profile/data/repo/profile_repo_impl.dart' as _i341;
import '../../feature/profile/domain/repo/profile_repo.dart' as _i53;
import '../../feature/profile/presentation/view_model/profile_view_model.dart'
    as _i672;
import '../api/api_client.dart' as _i277;
import '../api/api_module.dart' as _i0;
import '../services/camera_service.dart' as _i860;
import '../services/video_picker_service.dart' as _i401;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final apiModule = _$ApiModule();
    gh.factory<_i860.CameraService>(() => _i860.CameraService());
    gh.factory<_i401.VideoPickerService>(() => _i401.VideoPickerService());
    gh.lazySingleton<_i361.BaseOptions>(() => apiModule.providerOption());
    gh.lazySingleton<_i52.TalkerDioLogger>(() => apiModule.provideLogger());
    await gh.lazySingletonAsync<_i361.Dio>(
      () => apiModule.provideDio(
        gh<_i361.BaseOptions>(),
        gh<_i52.TalkerDioLogger>(),
      ),
      preResolve: true,
    );
    gh.lazySingleton<_i277.ApiClient>(
      () => apiModule.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i797.AiDataSource>(
      () => _i525.AiDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i282.CommunityDataSource>(
      () => _i82.CommunityDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i80.ProfileDataSource>(
      () => _i295.ProfileDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i238.HomeDataSource>(
      () => _i83.HomeDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i868.AuthDataSource>(
      () => _i364.AuthDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i480.CommunityRepo>(
      () => _i919.CommunityRepoImpl(gh<_i282.CommunityDataSource>()),
    );
    gh.lazySingleton<_i518.HomeRepo>(
      () => _i909.HomeRepoImpl(gh<_i238.HomeDataSource>()),
    );
    gh.lazySingleton<_i914.AiRepo>(
      () => _i472.AiRepoImpl(gh<_i797.AiDataSource>()),
    );
    gh.factory<_i84.AiViewModel>(() => _i84.AiViewModel(gh<_i914.AiRepo>()));
    gh.factory<_i402.ChatViewModel>(
      () => _i402.ChatViewModel(gh<_i914.AiRepo>()),
    );
    gh.lazySingleton<_i1021.AuthRepo>(
      () => _i945.AuthRepoImpl(gh<_i868.AuthDataSource>()),
    );
    gh.factory<_i769.CommunityViewModel>(
      () => _i769.CommunityViewModel(gh<_i480.CommunityRepo>()),
    );
    gh.lazySingleton<_i53.ProfileRepo>(
      () => _i341.ProfileRepoImpl(gh<_i80.ProfileDataSource>()),
    );
    gh.factory<_i502.VideoRecordViewModel>(
      () => _i502.VideoRecordViewModel(
        gh<_i860.CameraService>(),
        gh<_i518.HomeRepo>(),
      ),
    );
    gh.factory<_i416.AnalysisViewModel>(
      () => _i416.AnalysisViewModel(gh<_i518.HomeRepo>()),
    );
    gh.factory<_i847.CommunityFeedViewModel>(
      () => _i847.CommunityFeedViewModel(gh<_i518.HomeRepo>()),
    );
    gh.factory<_i60.HomeViewModel>(
      () => _i60.HomeViewModel(
        gh<_i518.HomeRepo>(),
        gh<_i401.VideoPickerService>(),
      ),
    );
    gh.factory<_i117.AuthViewModel>(
      () => _i117.AuthViewModel(gh<_i1021.AuthRepo>()),
    );
    gh.factory<_i672.ProfileViewModel>(
      () => _i672.ProfileViewModel(gh<_i53.ProfileRepo>()),
    );
    return this;
  }
}

class _$ApiModule extends _i0.ApiModule {}
