import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/lookups/data/models/language_model.dart';
import 'package:isnad_worker/core/lookups/domain/repo/lookups_repo.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';

class GetLanguagesUseCase implements UseCase<List<LanguageModel>, NoParams> {
  final LookupsRepo repository;

  GetLanguagesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<LanguageModel>>> call(NoParams params) =>
      repository.getLanguages();
}
