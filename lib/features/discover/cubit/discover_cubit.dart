import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit() : super(DiscoverInitial());
}
