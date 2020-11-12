import 'package:dio/dio.dart';
import 'package:dio_app/app/modules/shared/custom_dio/custom_dio.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:dio_app/app/app_widget.dart';
import 'package:dio_app/app/modules/home/home_module.dart';

import 'modules/home/home_repository.dart';
import 'modules/home/subpages/create/create_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $AppController,
        Bind((_) => Dio()),
        Bind((i) => CustomDio(AppModule.to.get<Dio>())),
        Bind((i) => HomeRepository(AppModule.to.get<CustomDio>()))
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: HomeModule()),
        ModularRouter('/create', module: CreateModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
