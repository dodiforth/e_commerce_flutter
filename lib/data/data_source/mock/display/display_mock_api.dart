import 'dart:convert';
import 'dart:io';

import '../../../dto/common/response_wrapper/response_wrapper.dart';
import '../../../dto/display/menu/menu.dto.dart';
import '../../remote/display/display.api.dart';
import 'display_mock_data.dart';

class DisplayMockApi implements DisplayApi {
  @override
  Future<ResponseWrapper<List<MenuDto>>> getMenusByMallType(String mallType) {
    return Future(
      () => ResponseWrapper(
        status: 'SUCCESS', //fail / SUCCESS -> Change to fail if want to test
        code: '0000', //GNB-0000 / 0000 -> Change to GNB-0000 if want to test
        message: '', //service error has occurred / '' -> Change to 'service error has occurred' if want to test
        data: menuParser(mallType == 'market'
            ? DisplayMockData.menusByMarket
            : DisplayMockData.menusByBeauty),
      ),
    );
  }

  List<MenuDto> menuParser(String source) {
    List<MenuDto> menus = [];
    final List json = jsonDecode(source);
    menus = json.map((e) => MenuDto.fromJson(e)).toList();

    return menus;
  } // String data to MenuDto
}
