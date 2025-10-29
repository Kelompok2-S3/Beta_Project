import 'package:beta_project/cubits/app_menu/app_menu_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppMenuCubit extends Cubit<AppMenuState> {
  AppMenuCubit() : super(const AppMenuState());

  void selectMenu(String menu) {
    if (state.selectedMenu == menu) {
      // Deselect if the same menu is clicked again
      emit(state.copyWith(forceNullMenu: true, forceNullBrand: true));
    } else {
      emit(state.copyWith(selectedMenu: menu, forceNullBrand: true));
    }
  }

  void selectBrand(String brand) {
    emit(state.copyWith(selectedBrand: brand));
  }

  void backToBrands() {
    emit(state.copyWith(forceNullBrand: true));
  }

  void reset() {
    emit(const AppMenuState());
  }
}
