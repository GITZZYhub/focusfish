import '../focus.dart';

abstract class IFocusRepository {

}

class FocusRepository implements IFocusRepository {
  FocusRepository({required final this.provider});
  final IFocusProvider provider;
}
