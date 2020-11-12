import 'package:dio_app/app/modules/shared/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Posts"}) : super(key: key);

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
      body: FutureBuilder<List<PostModel>>(
        future: controller.repository.getPosts(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('ERRO'),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return _postCard(context, snapshot.data[index]);
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/create').then((result) {
              if (result != null) {
                _showMyDialog(result);
              } else {
                _showMyDialog(false);
              }
            });
          }),
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

  Future<void> _showMyDialog(bool result) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(result ? "Sucesso!" : "ERRO!"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(result
                    ? "O Post foi criado e já está disponível para seus leitores!"
                    : "Ocorreu um problema e o posta não foi criado, tente novamente."),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(result?"Legal!":"Que pena."),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
