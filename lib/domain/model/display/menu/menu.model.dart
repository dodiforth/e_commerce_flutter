import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu.model.freezed.dart';
part 'menu.model.g.dart';

@freezed
class Menu with _$Menu {
  const factory Menu({
    required String title,
    required int tabId,
  }) = _Menu;



  factory Menu.fromJson(Map<String, dynamic> json) =>
      _$MenuFromJson(json);
}