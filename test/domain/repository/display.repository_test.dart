import 'package:e_commerce_app/data/data_source/mock/display/display_mock_api.dart';
import 'package:e_commerce_app/data/data_source/remote/display/display.api.dart';
import 'package:e_commerce_app/data/dto/common/response_wrapper/response_wrapper.dart';
import 'package:e_commerce_app/data/dto/display/menu/menu.dto.dart';
import 'package:e_commerce_app/data/mapper/common.mapper.dart';
import 'package:e_commerce_app/data/mapper/display.mapper.dart';
import 'package:e_commerce_app/data/repository_impl/display.repository_impl.dart';
import 'package:e_commerce_app/domain/model/display/menu/menu.model.dart';
import 'package:e_commerce_app/domain/repository/display.repository.dart';
import 'package:e_commerce_app/presentation/main/cubit/mall_type_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDisplayApi extends Mock implements DisplayApi {}

void main() {
  late DisplayRepository displayRepository;
  late DisplayApi displayApi;

  setUpAll(() {
    displayApi = MockDisplayApi();
    displayRepository = DisplayRepositoryImpl(displayApi);
  });

  test('dependency injection and instance check',
      () => expect(displayRepository, isNotNull));

  group('call menu list', () {
    //success to call API
    test('api call completed', () async {
      try {
        await displayRepository.getMenusByMallType(mallType: MallType.market);
      } catch (_) {}
      verify(() => displayApi.getMenusByMallType(any())).called(1);
    });
    test('api fail', () async {
      final exception = Exception('error');
      when(() => displayApi.getMenusByMallType(any())).thenThrow(exception);
      expect(
          () => displayRepository.getMenusByMallType(mallType: MallType.market),
          throwsA(exception));
    });

    test('api call success', () async {
      final MallType mallType = MallType.market;
      final ResponseWrapper<List<MenuDto>> mockingData =
          await DisplayMockApi().getMenusByMallType(mallType.name);

      when(() => displayApi.getMenusByMallType(any())).thenAnswer((_) async => mockingData);

      final actual = await displayRepository.getMenusByMallType(mallType: mallType);

      final expected = mockingData.toModel<List<Menu>>(
        mockingData.data?.map((menuDto) => menuDto.toModel()).toList() ?? [],
      );

      expect(expected, actual);

    });
  });
}
