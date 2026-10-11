import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/lookups/data/models/job_model.dart';
import 'package:isnad_worker/core/lookups/domain/repo/lookups_repo.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/lookup_query_params.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';

class GetJobTitlesUseCase
    implements UseCase<List<JobModel>, GetJobTitlesUseCaseParams> {
  final LookupsRepo repository;

  GetJobTitlesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<JobModel>>> call(
    GetJobTitlesUseCaseParams params,
  ) async {
    return await repository.getJobTitles(params);
  }
}

class GetJobTitlesUseCaseParams {
  final LookupQueryParams query;

  const GetJobTitlesUseCaseParams({this.query = const LookupQueryParams()});

  Map<String, dynamic> toMap() => {'IsActive': 'true', ...query.toMap()};
}
