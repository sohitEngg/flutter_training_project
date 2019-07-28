import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Person extends Equatable {
  String name;

  Person(this.name) : super([name]);
}

class PersonListState extends Equatable {
  final List<Person> persons;

  PersonListState({this.persons}) : super(persons);

  @override
  String toString() => 'PersonListState = { persons : $persons }';
}
