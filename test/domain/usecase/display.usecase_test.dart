
import 'dart:math';

import 'package:e_commerce_app/core/utils/error/error_response.dart';
import 'package:e_commerce_app/data/data_source/remote/display/display.api.dart';
import 'package:e_commerce_app/data/repository_impl/display.repository_impl.dart';
import 'package:e_commerce_app/domain/model/common/result.dart';
import 'package:e_commerce_app/domain/model/display/menu/menu.model.dart';
import 'package:e_commerce_app/domain/repository/display.repository.dart';
import 'package:e_commerce_app/domain/usecase/display/display.usecase.dart';
import 'package:e_commerce_app/domain/usecase/display/menu/get_menus.usecase.dart';
import 'package:e_commerce_app/presentation/main/cubit/mall_type_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDisplayApi extends Mock implements DisplayApi {}

class MockDisplayRepository extends Mock implements DisplayRepository {}

class MockGetMenusUsecase extends Mock implements GetMenusUsecase{}

void main() {

  late DisplayRepository displayRepository;
  late DisplayUsecase displayUsecase;

  setUpAll(() {
    displayRepository = DisplayRepositoryImpl(MockDisplayApi());
    displayUsecase = DisplayUsecase(displayRepository);
  });

  test('dependency injection success', () => expect(displayUsecase, isNotNull));

  test('call menu list success', () async {
    final result = Result.success([Menu(title: 'menu test', tabId: -1)]);
    final usecase = MockGetMenusUsecase();

    when(() => usecase.mallType).thenReturn(MallType.market);
    when(() => usecase.call(displayRepository)).thenAnswer((_) async => result);
    
    final actual = await displayUsecase.execute(usecase: usecase);
    
    expect(actual, result);
  });

  test('call menu list failed', () async {
    final result = Result<List<Menu>>.failure(ErrorResponse(status: 'fail', message: 'fail'));
    final usecase = MockGetMenusUsecase();

    when(() => usecase.mallType).thenReturn(MallType.market);
    when(() => usecase.call(displayRepository)).thenAnswer((_) async => result);

    final actual = await displayUsecase.execute(usecase: usecase);

    expect(actual, result);
  });
}