import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'events.dart';

class BlocSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc _bloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('bloc counter sample'),
        ),
        body: BlocBuilder<CounterEvent, int>(
            bloc: _bloc,
            builder: (BuildContext context, int count) {
              return Center(
                child: Text('$count'),
              );
            }),
        floatingActionButton: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: FloatingActionButton(
                child: Icon(Icons.remove),
                onPressed: () {
                  _bloc.dispatch(CounterEvent.decrement);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  _bloc.dispatch(CounterEvent.increment);
                },
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ));
  }
}
