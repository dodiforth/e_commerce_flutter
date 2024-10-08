import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constant.dart';
import '../../../core/utils/dialog/common_dialog.dart';
import '../../../domain/usecase/display/display.usecase.dart';
import '../../../service_locator.dart';
import '../../main/cubit/mall_type_cubit.dart';
import 'bloc/menu_bloc/menu_bloc.dart';
import 'component/global_nav/global_nav_bar.dart';
import 'component/global_nav/global_nav_bar_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MallTypeCubit, MallType>(builder: (context, state) {
      return BlocProvider(
        create: (_) => MenuBloc(locator<DisplayUsecase>())
          ..add(
            MenuInitialized(mallType: state),
          ),
        child: const HomePageView(),
      );
    });
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MallTypeCubit, MallType>(
      listener: (context, state) =>
          context.read<MenuBloc>().add(MenuInitialized(mallType: state)),
      listenWhen: (prev, curr) => prev.index != curr.index,
      child: BlocConsumer<MenuBloc, MenuState>(
        builder: (_, state) {
          switch (state.status) {
            case Status.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.loading:
              return DefaultTabController(
                key: ValueKey<MallType>(state.mallType),
                length: state.menus.length,
                child: Column(
                  children: [
                    GlobalNavBar(state.menus),
                    GlobalNavBarView(state.mallType, state.menus),
                  ],
                ),
              );
            case Status.success:
              return DefaultTabController(
                key: ValueKey<MallType>(state.mallType),
                length: state.menus.length,
                child: Column(
                  children: [
                    GlobalNavBar(state.menus),
                    GlobalNavBarView(state.mallType, state.menus),
                  ],
                ),
              );

            case Status.error:
              return Center(
                child: Text('error'),
              );
          }
        },
        listener: (context, state) async {
          if (state.status == Status.error) {
            final bool result =
                (await CommonDialog.errorDialog(context, state.error) ?? false);

            if (result) {
              context
                  .read<MenuBloc>()
                  .add(MenuInitialized(mallType: state.mallType));
            }
          }
        },
        listenWhen: (prev, curr) => prev.status != curr.status,
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Home Page'),
    //   ),
    //   body: Center(
    //     child: Text(
    //       'Home Page',
    //       style: TextStyle(
    //         fontSize: 30,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //   ),
    // );
  }
}
