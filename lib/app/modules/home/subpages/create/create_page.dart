import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'create_controller.dart';

class CreatePage extends StatefulWidget {
  final String title;
  const CreatePage({Key key, this.title = "Create Post"}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends ModularState<CreatePage, CreateController> {
  //use 'controller' variable to access controller

  GlobalKey<FormState> _key = new GlobalKey();

  bool _validate = false;

  void _sendForm() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
     controller.savePost().then(
            (value) {
              if (value == 200 || value == 201) {
                Navigator.pop(context, true);
              } else {
                 Navigator.pop(context, false);
              }
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          autovalidate: _validate,
          child: Column(
            children: [
              TextFormField(
                maxLength: 30,
                validator: controller.validatorTitle,
                onSaved: (String text) {
                  controller.title = text;
                },
              ),
              TextFormField(
                maxLength: 300,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                validator: controller.validatorBody,
                onSaved: (String text) {
                  controller.body = text;
                },
              ),
              FlatButton(
                child: Text("Criar"),
                onPressed: () {
                  _sendForm();
                },
              ),
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
