

import '../../domain/repository/calendar_repository.dart';
import '../data_source/calendar_remote_data_source.dart';


 class CalendarRepositoryImp implements CalendarRepository  {
  CalendarRepositoryImp(this._remoteDataSource);
 
  final CalendarRemoteDataSource _remoteDataSource;
}