import 'package:flutter_bloc/flutter_bloc.dart';

class VideoMuteCubit extends Cubit<bool> {
  // Initial state is true (video is muted)
  VideoMuteCubit() : super(true);

  // Toggles the current state
  void toggleMute() => emit(!state);
}
