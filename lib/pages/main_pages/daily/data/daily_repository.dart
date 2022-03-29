import '../daily.dart';

abstract class IDailyRepository {

}

class DailyRepository implements IDailyRepository {
  DailyRepository({required final this.provider});
  final IDailyProvider provider;
}
