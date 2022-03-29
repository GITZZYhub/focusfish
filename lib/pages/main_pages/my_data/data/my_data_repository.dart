import '../my_data.dart';

abstract class IMyDataRepository {

}

class MyDataRepository implements IMyDataRepository {
  MyDataRepository({required final this.provider});
  final IMyDataProvider provider;
}
