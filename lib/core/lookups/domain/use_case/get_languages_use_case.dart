import 'package:dartz/dartz.dart';
import 'package:isnad_worker/core/lookups/data/models/language_model.dart';
import 'package:isnad_worker/core/lookups/domain/repo/lookups_repo.dart';
import 'package:isnad_worker/core/lookups/domain/use_case/lookup_query_params.dart';
import 'package:isnad_worker/core/network/errors/failure.dart';
import 'package:isnad_worker/core/usecase/usecase.dart';

class GetLanguagesUseCase
    implements UseCase<List<LanguageModel>, GetLanguagesUseCaseParams> {
  final LookupsRepo repository;

  GetLanguagesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<LanguageModel>>> call(
    GetLanguagesUseCaseParams params,
  ) => repository.getLanguages(params);
}

class GetLanguagesUseCaseParams {
  final LookupQueryParams query;

  const GetLanguagesUseCaseParams({this.query = const LookupQueryParams()});

  Map<String, dynamic> toMap() => query.toMap();
}
