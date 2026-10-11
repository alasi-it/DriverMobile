import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/lookups/data/models/skill_model.dart';
import 'package:isnad_worker/core/lookups/domain/repo/lookups_repo.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/lookup_query_params.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';

class GetSkillsUseCase
    implements UseCase<List<SkillModel>, GetSkillsUseCaseParams> {
  final LookupsRepo repository;

  GetSkillsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<SkillModel>>> call(
    GetSkillsUseCaseParams params,
  ) async {
    return await repository.getSkills(params);
  }
}

class GetSkillsUseCaseParams {
  final LookupQueryParams query;

  const GetSkillsUseCaseParams({this.query = const LookupQueryParams()});

  Map<String, dynamic> toMap() => {'IsActive': 'true', ...query.toMap()};
}
