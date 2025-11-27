

import '../../domain/repository/list_repository.dart';
import '../data_source/list_remote_data_source.dart';


 class ListRepositoryImp implements ListRepository  {
  ListRepositoryImp(this._remoteDataSource);
 
  final ListRemoteDataSource _remoteDataSource;
}