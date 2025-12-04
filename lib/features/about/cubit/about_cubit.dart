import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit() : super(AboutInitial());
}
