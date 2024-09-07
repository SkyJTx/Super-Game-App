import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_page_state.dart';

class MainBloc extends Cubit<MainState> {
  MainBloc() : super(HomeState());

  void showHome() => emit(HomeState());
  void showHoYoVerse() => emit(HoYoVerseState());
  void showKuroGame() => emit(KuroGameState());
  void showSettings() => emit(SettingsState());
}
