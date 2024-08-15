import 'package:e_commerce_app/presentation/main/cubit/mall_type_cubit.dart';

import 'core/logger.dart';
import 'core/utils/exception/common_exception.dart';
import 'data/data_source/mock/display/display_mock_api.dart';
import 'data/repository_impl/display.repository_impl.dart';
import 'domain/usecase/display/display.usecase.dart';
import 'domain/usecase/display/menu/get_menus.usecase.dart';
import 'service_locator.dart';
import 'package:flutter/material.dart';

import 'core/theme/theme_data.dart';
import 'presentation/routes/routes.dart';

void main() async {
  setLocator();

  try {
    final test = await DisplayMockApi().getMenusByMallType('market');
    CustomLogger.logger.d(test);
  } catch(error){
    final errorData = CommonException.setError(error);
    CustomLogger.logger.e(errorData);
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: CustomThemeData.themeData,
    );
  }
}
