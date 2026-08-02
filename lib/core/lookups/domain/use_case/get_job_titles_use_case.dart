import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/lookups/data/models/job_model.dart';
import 'package:isnad_worker/core/lookups/domain/repo/lookups_repo.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';

class GetJobTitlesUseCase implements UseCase<List<JobModel>, NoParams> {
  final LookupsRepo repository;

  GetJobTitlesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<JobModel>>> call(NoParams params) async {
    return await repository.getJobTitles();
  }
}
