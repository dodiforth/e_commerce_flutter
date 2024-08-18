part of 'menu_bloc.dart';

abstract class MenuEvent {
  const MenuEvent();
}

class MenuInitialized extends MenuEvent {
  // final MallType malltype;
  final MallType mallType;

  MenuInitialized({this.mallType = MallType.market});
}