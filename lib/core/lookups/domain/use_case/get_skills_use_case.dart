import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/lookups/data/models/skill_model.dart';
import 'package:isnad_worker/core/lookups/domain/repo/lookups_repo.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';

class GetSkillsUseCase implements UseCase<List<SkillModel>, NoParams> {
  final LookupsRepo repository;

  GetSkillsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<SkillModel>>> call(NoParams params) async {
    return await repository.getSkills();
  }
}
