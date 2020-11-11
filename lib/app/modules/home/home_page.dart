import 'package:dio_app/app/modules/shared/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: controller.posts.length,
            itemBuilder: (BuildContext context, int index) {
              return _postCard(context, controller.posts[index]);
            },
          );
        },
      ),
    );
  }

  Widget _postCard(BuildContext context, PostModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text("POST ${model.id} - ${model.title.toUpperCase()}"),
          subtitle: Text("${model.body}"),
        ),
      ),
    );
  }
}
