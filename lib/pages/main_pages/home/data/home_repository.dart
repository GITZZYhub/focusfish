import '../home.dart';

abstract class IHomeRepository {

}

class HomeRepository implements IHomeRepository {
  HomeRepository({required final this.provider});
  final IHomeProvider provider;
}
