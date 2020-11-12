import 'package:dio_app/app/modules/shared/errors.dart';
import 'package:dio_app/app/modules/shared/models/post_model.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../home_repository.dart';

part 'create_controller.g.dart';

@Injectable()
class CreateController = _CreateControllerBase with _$CreateController;

abstract class _CreateControllerBase with Store {
  final HomeRepository repository;
  String title;
  String body;

  Future<int> savePost() async {
    var post = PostModel(title: title, body: body);
    try {
      return repository.createPost(post);
    }  on PostError catch (e){
      return e.code;
    }
  }

  String validatorTitle(String text) {
    if (text.length == 0) {
      return "Informe o título";
    }
    if (text.length < 3) {
      return "titulo deve ter pelo menos 3 caracteres";
    }
    return null;
  }

  String validatorBody(String text) {
    if (text.length == 0) {
      return "Informe o corpo do texto.";
    }
    if (text.length < 30) {
      return "O corpo do texto deve ter pelo menos 30 caracteres";
    }
    return null;
  }

  _CreateControllerBase(this.repository);
}
