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
                _showResponse(result);
              } else {
                _showResponse(false);
              }
            });
          }),
    );
  }

  Widget _postCard(BuildContext context, PostModel post) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed('/create', arguments: post).then((result) {
          if (result != null) {
            _showResponse(result);
          } else {
            _showResponse(false);
          }
        });
      },
      onLongPress: (){
        _showDeleteDialog(post.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            title: Text("POST ${post.id} - ${post.title.toUpperCase()}"),
            subtitle: Text("${post.body}"),
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Deletar post?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Confirmar"),
              onPressed: () {
                controller.repository.deletePost(id).then((value){
                  Navigator.of(context).pop();
                });
              },
            ),
             FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showResponse(bool result) async {
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
              child: Text(result ? "Legal!" : "Que pena."),
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
