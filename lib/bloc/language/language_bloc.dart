import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'language_event.dart';
part 'language_state.dart';


enum LanguageEnums { english, hindi }

LanguageEnums selectedLanguage = LanguageEnums.english;

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {

    on<LanguageChangeEvent>((event, emit) {
      emit(LanguageChangeState(language: event.language));
    });
  }
}
