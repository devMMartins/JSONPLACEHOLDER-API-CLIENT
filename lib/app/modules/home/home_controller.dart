import 'package:dio_app/app/modules/home/home_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController; 

abstract class _HomeControllerBase with Store {
  final HomeRepository repository;

  @observable
  ObservableList posts = ObservableList();

  _HomeControllerBase(this.repository) {
    autorun((_) {
      print("autorun");
      _getPosts();
    });
  }

  @action
  _getPosts() {
    try {
      repository.getPosts().then((value) {
        posts = ObservableList.of(value);
      });
    } on Exception catch (e) {
      throw e;
    }
  }
}
