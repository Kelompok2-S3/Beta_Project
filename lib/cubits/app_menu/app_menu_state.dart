import 'package:equatable/equatable.dart';

class AppMenuState extends Equatable {
  final String? selectedMenu;
  final String? selectedBrand;

  const AppMenuState({
    this.selectedMenu,
    this.selectedBrand,
  });

  AppMenuState copyWith({
    String? selectedMenu,
    String? selectedBrand,
    bool forceNullMenu = false,
    bool forceNullBrand = false,
  }) {
    return AppMenuState(
      selectedMenu: forceNullMenu ? null : selectedMenu ?? this.selectedMenu,
      selectedBrand: forceNullBrand ? null : selectedBrand ?? this.selectedBrand,
    );
  }

  @override
  List<Object?> get props => [selectedMenu, selectedBrand];
}
