import '../../domain/repository/dash_board_repository.dart';
import '../data_source/dash_board_remote_data_source.dart';

class DashBoardRepositoryImp implements DashBoardRepository  {
  DashBoardRepositoryImp(this._remoteDataSource);
 
  final DashBoardRemoteDataSource _remoteDataSource;
}