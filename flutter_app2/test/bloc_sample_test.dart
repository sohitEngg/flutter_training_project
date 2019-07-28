import 'package:flutter_app2/bloc_example/bloc.dart';
import 'package:flutter_app2/bloc_example/events.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterBloc', () {
    CounterBloc counterBloc;

    setUp(() {
      counterBloc = CounterBloc();
    });

    test('test initial state as 0', () {
      expect(counterBloc.initialState, 0);
    });

    test('test increment counter by 1', () {
      List<int> expectedStateOrder = [0, 1];
      expectLater(counterBloc.state, emitsInOrder(expectedStateOrder));

      counterBloc.dispatch(CounterEvent.increment);
    });
  });
}
