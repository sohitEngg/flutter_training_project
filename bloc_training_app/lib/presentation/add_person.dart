import 'package:bloc_training_app/bloc/event/bloc_event.dart';
import 'package:bloc_training_app/bloc/add_person_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPersonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController editController = TextEditingController();
    AddPersonBloc _bloc = BlocProvider.of<AddPersonBloc>(context);

    _validateNameEvent(String personName) {
      _bloc.dispatch(ValidateNameEvent(personName));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Add Person'),
        ),
        body: BlocBuilder(
            bloc: _bloc,
            builder: (BuildContext context, int state) {
              return Center(
                  child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(children: <Widget>[
                        TextField(
                            key: Key('nameTextField'),
                            controller: editController,
                            onChanged: (text) =>
                                _validateNameEvent(editController.text),
                            decoration: InputDecoration(
                                labelText: 'Enter person name',
                                errorText: (state == AddPersonBloc.VALID ||
                                        state == AddPersonBloc.DEFAULT)
                                    ? null
                                    : 'Please enter a valid name',
                                hintText: 'abc')),
                        RaisedButton(
                          child: Text(
                            'DONE',
                            style: TextStyle(
                                color: state == AddPersonBloc.VALID
                                    ? Colors.black
                                    : Colors.grey),
                          ),
                          onPressed: () => state == AddPersonBloc.VALID
                              ? _submit(context, editController.text)
                              : null,
                        )
                      ])));
            }));
  }

  void _submit(BuildContext context, String name) {
    Navigator.pop(context, name);
  }
}
