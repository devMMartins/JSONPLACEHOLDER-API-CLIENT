import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/models/post_model.dart';
import '../../../shared/models/post_model.dart';
import 'create_controller.dart';

class CreatePage extends StatefulWidget {
  final PostModel post;
  final String title;
  const CreatePage({Key key, this.title = "Create Post", this.post})
      : super(key: key);

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
      if (controller.post.id != null) {
        //editando
        _updatePost();
      } else {
        _savePost();
      }
    }
  }

  _savePost() {
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

  _updatePost() {
    controller.updatePost().then(
      (value) {
        if (value == 200 || value == 201) {
          Navigator.pop(context, true);
        } else {
          Navigator.pop(context, false);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      controller.post = widget.post;
    } else {
      controller.post = PostModel();
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
                initialValue: controller.post.title,
                onSaved: (String text) {
                  controller.post.title = text;
                },
              ),
              TextFormField(
                maxLength: 300,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                validator: controller.validatorBody,
                initialValue: controller.post.body,
                onSaved: (String text) {
                  controller.post.body = text;
                },
              ),
              FlatButton(
                child: Text(controller.post.id != null? "Modificar":"Criar"),
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
