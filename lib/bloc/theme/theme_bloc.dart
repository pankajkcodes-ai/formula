import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {

    on<ThemeChangeEvent>((event, emit) {
      emit(ThemeChangeState(isDark: event.isDark));
    });
  }
}
