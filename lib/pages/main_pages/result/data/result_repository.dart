import '../result.dart';

abstract class IResultRepository {

}

class ResultRepository implements IResultRepository {
  ResultRepository({required final this.provider});
  final IResultProvider provider;
}
