import 'package:bloc_training_app/bloc/add_person_bloc.dart';
import 'package:bloc_training_app/bloc/event/bloc_event.dart';
import 'package:bloc_training_app/bloc/person_list_bloc.dart';
import 'package:bloc_training_app/model/person.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Test cases for the Add Person Bloc
  group('AddPersonBloc', () {
    AddPersonBloc addPersonBloc;

    setUp(() {
      addPersonBloc = AddPersonBloc();
    });

    test('test person name default valid', () {
      expect(addPersonBloc.currentState, AddPersonBloc.DEFAULT);
    });

    test('test person name valid', () {
      List<int> expectedSequence = [AddPersonBloc.DEFAULT, AddPersonBloc.VALID];

      addPersonBloc.dispatch(ValidateNameEvent("Suresh"));

      expectLater(addPersonBloc.state, emitsInOrder(expectedSequence));
    });

    test('test person name invalid when empty', () {
      List<int> expectedSequence = [
        AddPersonBloc.DEFAULT,
        AddPersonBloc.INVALID
      ];

      addPersonBloc.dispatch(ValidateNameEvent(""));

      expectLater(addPersonBloc.state, emitsInOrder(expectedSequence));
    });

    test('test person name invalid when null', () {
      List<int> expectedSequence = [
        AddPersonBloc.DEFAULT,
        AddPersonBloc.INVALID
      ];

      addPersonBloc.dispatch(ValidateNameEvent(null));

      expectLater(addPersonBloc.state, emitsInOrder(expectedSequence));
    });

    test('test person name invalid when it contains numeric value', () {
      List<int> expectedSequence = [
        AddPersonBloc.DEFAULT,
        AddPersonBloc.INVALID
      ];

      addPersonBloc.dispatch(ValidateNameEvent("Suresh1988"));

      expectLater(addPersonBloc.state, emitsInOrder(expectedSequence));
    });
  });

  // Test cases for Person Bloc
  group('PersonBloc', () {
    PersonListBloc personBloc;

    setUp(() {
      personBloc = PersonListBloc();
    });

    test('test initial state is 3 persons', () {
      expect(personBloc.initialState.persons.length, 3);
    });

    test('test person incresed after adding one', () {
      List<Person> _newLst = [
        Person('Suresh'),
        Person('Gagan'),
        Person('Neeraj'),
        Person('suresh')
      ];

      expectLater(personBloc.state,
          emits((val) => val == PersonListState(persons: _newLst)));

      personBloc.dispatch(AddPersonEvent(Person('suresh')));
    });
  });
}
