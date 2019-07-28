import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_training_app/model/person.dart';

import 'event/bloc_event.dart';

class PersonListBloc extends Bloc<BlocEvent, PersonListState> {
  List<Person> _list = [Person('Suresh'), Person('Gagan'), Person('Neeraj')];

  get _getPersonList => PersonListState(persons: _list);

  @override
  PersonListState get initialState => _getPersonList;

  @override
  Stream<PersonListState> mapEventToState(BlocEvent event) async* {
    if (event is AddPersonEvent) {
      _addNewPerson(event.person);
      yield _getPersonList;
    }
  }

  _addNewPerson(Person person) {
    _list.add(person);
  }
}
