import 'package:bloc_training_app/bloc/add_person_bloc.dart';
import 'package:bloc_training_app/bloc/person_list_bloc.dart';
import 'package:bloc_training_app/model/person.dart';
import 'package:bloc_training_app/presentation/add_person.dart';
import 'package:bloc_training_app/presentation/person_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAddPersonBloc extends Mock implements AddPersonBloc {}

class MockPersonListBloc extends Mock implements PersonListBloc {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  final mockNavigatorObserver = MockNavigatorObserver();

  group('Person List Widget test', () {
    PersonListBloc personListBloc;

    setUp(() {
      personListBloc = MockPersonListBloc();
    });

    Widget makeTestableWidget(Widget child) {
      return MaterialApp(
        home: child,
        navigatorObservers: [mockNavigatorObserver],
      );
    }

    testWidgets('test no record found widget when null list',
        (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<PersonListBloc>(
          builder: (context) => personListBloc,
          child: makeTestableWidget(PersonListPage())));

      expect(find.text('No records found'), findsOneWidget);
      expect(find.byType(ListTile), findsNothing);
      expect(find.byKey(Key('fab')), findsOneWidget);
    });

    testWidgets('test no record found widget when empty list',
        (WidgetTester tester) async {
      when(personListBloc.currentState)
          .thenAnswer((_) => PersonListState(persons: List<Person>()));

      await tester.pumpWidget(BlocProvider<PersonListBloc>(
          builder: (context) => personListBloc,
          child: makeTestableWidget(PersonListPage())));

      expect(find.text('No records found'), findsOneWidget);
      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('test list items to be populated correctly',
        (WidgetTester tester) async {
      //when(personListBloc.state).thenAnswer((_) => Stream.empty());
      when(personListBloc.currentState).thenAnswer((_) =>
          PersonListState(persons: [Person('suresh'), Person('ramesh')]));

      await tester.pumpWidget(BlocProvider<PersonListBloc>(
        builder: (context) => personListBloc,
        child: makeTestableWidget(PersonListPage()),
      ));

      expect(find.byType(ListTile), findsNWidgets(2));
      expect(find.text('suresh'), findsOneWidget);
      expect(find.text('ramesh'), findsOneWidget);
      expect(find.text('No records found'), findsNothing);
    });

    testWidgets('test navigate to AddPersonPage on click plus btn',
        (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<PersonListBloc>(
        builder: (context) => personListBloc,
        child: makeTestableWidget(PersonListPage()),
      ));

      await tester.tap(find.byKey(Key('fab')));
      await tester.pumpAndSettle();

      verify(mockNavigatorObserver.didPush(typed(any), typed(any)));
      expect(find.byType(AddPersonPage), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(RaisedButton), findsOneWidget);
    });
  });

  group('Add person widget test', () {
    AddPersonBloc addPersonBloc;

    Widget makeTestableAddPersonPage(Widget child) {
      return MaterialApp(
        home: child,
        navigatorObservers: [mockNavigatorObserver],
      );
    }

    setUp(() {
      addPersonBloc = MockAddPersonBloc();
    });

    testWidgets('test valid person name entered', (WidgetTester tester) async {
      when(addPersonBloc.currentState).thenAnswer((_) => AddPersonBloc.DEFAULT);

      await tester.pumpWidget(BlocProvider<AddPersonBloc>(
        builder: (context) => addPersonBloc,
        child: makeTestableAddPersonPage(AddPersonPage()),
      ));

      await tester.tap(find.byType(RaisedButton));
      await tester.pumpAndSettle();

      expect(
          find.descendant(
              of: find.byType(RaisedButton), matching: find.byType(TextStyle)),
          findsOneWidget);

      verify(mockNavigatorObserver.didPop(typed(any), typed(any)));
    });

    testWidgets('test invalid person name entered',
        (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<AddPersonBloc>(
        builder: (context) => addPersonBloc,
        child: makeTestableAddPersonPage(AddPersonPage()),
      ));

      await tester.enterText(find.byKey(Key('nameTextField')), "123");
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid name'), findsOneWidget);
    });
  });
}
