import 'package:bloc/bloc.dart';
import 'package:bloc_training_app/bloc/event/bloc_event.dart';
import 'package:bloc_training_app/bloc/person_list_bloc.dart';
import 'package:bloc_training_app/bloc/add_person_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc_training_app/model/person.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_person.dart';

class PersonListPage extends StatefulWidget {
  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PersonListPage>
    with AutomaticKeepAliveClientMixin {
  PersonListBloc _bloc;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = SimpleBlocDelegate();
    _bloc = BlocProvider.of<PersonListBloc>(context);

    return Scaffold(
      body: BlocBuilder<BlocEvent, PersonListState>(
          bloc: _bloc,
          builder: (BuildContext context, PersonListState state) {
            return Container(
              child: _buildPersonLstItemWidget(state),
            );
          }),
      floatingActionButton: FloatingActionButton(
        key: const Key('fab'),
        onPressed: () => _navigateToAddPersonPage(context, _bloc),
        child: Icon(Icons.add),
      ),
    );
  }

  _buildPersonLstItemWidget(PersonListState state) {
    if (state != null) {
      List<Person> data = state.persons;
      return data.length > 0
          ? ListView.separated(
              itemCount: data.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (context, itemPosition) {
                final ListTile personItem =
                    new ListTile(title: Text(data[itemPosition].name));
                return personItem;
              },
            )
          : _noPersonWidget();
    } else {
      return _noPersonWidget();
    }
  }

  _noPersonWidget() {
    return Container(
        child: Center(
      child: Text('No records found'),
    ));
  }

  _addPersonEvent(PersonListBloc bloc, String name) {
    bloc.dispatch(AddPersonEvent(Person(name)));
  }

  _navigateToAddPersonPage(BuildContext context, PersonListBloc bloc) async {
    final personName = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider<AddPersonBloc>(
                  builder: (context) => AddPersonBloc(),
                  child: AddPersonPage(),
                )));

    if (personName != null) {
      _addPersonEvent(bloc, personName);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print('$error, $stacktrace');
  }
}

//Implementation through alert dialog
/*

enum DialogDemoAction { cancel, discard, disagree, agree }
  _showAddPersonDialog(PersonBloc bloc, BuildContext context) {
    TextEditingController editController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Person'),
            content: TextField(
                controller: editController,
                decoration: InputDecoration(hintText: 'Enter person name')),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('CANCEL')),
              new FlatButton(
                  onPressed: () {
                    if (editController.text.isNotEmpty) {
                      _addPersonEvent(bloc, editController.text);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('ADD'))
            ],
          );
        });
  }*/
