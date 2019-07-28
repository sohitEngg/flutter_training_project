import 'package:bloc/bloc.dart';
import 'package:bloc_training_app/bloc/event/bloc_event.dart';

class AddPersonBloc extends Bloc<BlocEvent, int> {
  static const int INVALID = 0;
  static const int VALID = 1;
  static const int DEFAULT = 2;

  @override
  int get initialState => DEFAULT;

  @override
  Stream<int> mapEventToState(BlocEvent event) async* {
    if (event is ValidateNameEvent) {
      yield _isValidName(event.personName);
    }
  }

  _isValidName(String personName) {
    return personName != null &&
            personName.length > 0 &&
            !_isNumberFound(personName)
        ? VALID
        : INVALID;
  }

  bool _isNumberFound(String str) {
    String pattern = r'[0-9]';
    RegExp regExp = new RegExp(pattern);
    return str.contains(regExp);
  }
}
