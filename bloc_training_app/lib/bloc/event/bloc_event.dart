import 'package:bloc_training_app/model/person.dart';

abstract class BlocEvent {}

class PersonListEvent extends BlocEvent {}

class AddPersonEvent extends BlocEvent {
  final Person person;

  AddPersonEvent(this.person);
}

class ValidateNameEvent extends BlocEvent {
  final String personName;

  ValidateNameEvent(this.personName);
}
