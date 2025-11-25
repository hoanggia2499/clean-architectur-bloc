 import 'package:your_default_package/dash_board/domain/repository/dash_board_repository.dart';
 import 'package:your_default_package/dash_board/data/data_source/dash_board_remote_data_source.dart';


 class DashBoardRepositoryImp implements DashBoardRepository  {
  DashBoardRepositoryImp(this._remoteDataSource);
 
  final DashBoardRemoteDataSource _remoteDataSource;
}