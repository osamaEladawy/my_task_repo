import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_task_products/core/apis/links/api_keys.dart';
import 'package:my_task_products/core/storage/pref_services.dart';
import 'package:my_task_products/features/admin/presentation/pages/admin_screen.dart';
import 'package:my_task_products/features/products/presentation/pages/home_screen.dart';
import 'package:my_task_products/features/home_tap/domain/entities/bottom_app_bar_model.dart';

part 'home_tap_state.dart';

class HomeTapCubit extends Cubit<HomeTapState> {
  HomeTapCubit() : super(HomeTapInitial());

  final PageController controller = PageController();

  int currentIndex =
      PrefServices.instance.getData(key: ApiKeys.role) == ApiKeys.user ? 0 : 1;

  List<Widget> pages = [HomeScreen(), AdminScreen()];

  void changePage(int index) {
    currentIndex = index;
    emit(SelectPage(index: index));
  }

  void changePageController(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
    emit(SelectPage(index: index));
  }

  List<BottomAppBarModel> bottomsBarPages = [
    BottomAppBarModel(id: 1, title: ApiKeys.user),
    BottomAppBarModel(id: 1, title: ApiKeys.admin),
  ];
}
