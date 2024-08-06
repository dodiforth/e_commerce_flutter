import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/custom/custom_app_bar.dart';

enum MallType { market, beauty}

class MallTypeCubit extends Cubit<MallType> {
  MallTypeCubit() : super(MallType.market);

  void changeIndex(int index) => emit(MallType.values[index]);
}

extension MallTypeX on MallType {
  String get toName {
    switch (this) {
      case MallType.market:
        return 'Fine Market';
      case MallType.beauty:
        return 'Fine Beauty';
    }
  }
  CustomAppBarTheme get theme {
    switch (this) {
      case MallType.market:
        return CustomAppBarTheme.market;
      case MallType.beauty:
        return CustomAppBarTheme.beauty;
    }
  }

  bool get isMarket => this == MallType.market;
  bool get isBeauty => this == MallType.beauty;
}