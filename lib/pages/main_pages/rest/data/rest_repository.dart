import '../rest.dart';

abstract class IRestRepository {

}

class RestRepository implements IRestRepository {
  RestRepository({required final this.provider});
  final IRestProvider provider;
}
