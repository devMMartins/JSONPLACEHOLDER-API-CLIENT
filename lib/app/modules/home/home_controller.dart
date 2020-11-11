import 'package:dio_app/app/modules/home/home_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController; 

abstract class _HomeControllerBase with Store {
  final HomeRepository repository;

  _HomeControllerBase(this.repository);
}
