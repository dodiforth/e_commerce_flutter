
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/constant/app_icons.dart';

enum BottomNav {home, category, search, user}

class BottomNavCubit extends Cubit<BottomNav>{
  BottomNavCubit() : super(BottomNav.home);

  void changeIndex(int index) => emit(BottomNav.values[index]); //change index according to bottom nav bar is clicked
}

extension BottomNavX on BottomNav {

  String get icon {
    switch (this) {
      case BottomNav.home:
        return AppIcons.navHome;
      case BottomNav.category:
        return AppIcons.navCategory;
      case BottomNav.search:
        return AppIcons.navSearch;
      case BottomNav.user:
        return AppIcons.navUser;
    }
  }

  String get activeIcon {
    switch (this) {
      case BottomNav.home:
        return AppIcons.navHomeOn;
      case BottomNav.category:
        return AppIcons.navCategoryOn;
      case BottomNav.search:
        return AppIcons.navSearchOn;
      case BottomNav.user:
        return AppIcons.navUserOn;
    }
  }

  String get toName {
    switch (this) {
      case BottomNav.home:
        return 'Home';
      case BottomNav.category:
        return 'Category';
      case BottomNav.search:
        return 'Search';
      case BottomNav.user:
        return 'My Page';
    }
  }
}