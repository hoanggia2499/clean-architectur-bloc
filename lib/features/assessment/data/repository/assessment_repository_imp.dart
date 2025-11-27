
import '../../domain/repository/assessment_repository.dart';
import '../data_source/assessment_remote_data_source.dart';


 class AssessmentRepositoryImp implements AssessmentRepository  {
  AssessmentRepositoryImp(this._remoteDataSource);
 
  final AssessmentRemoteDataSource _remoteDataSource;
}