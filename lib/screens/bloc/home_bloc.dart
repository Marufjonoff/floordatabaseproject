import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.dart';

part 'home_state.dart';

part 'home_bloc.freezed.dart';

class HomeBloc
    extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.state()) {
    on<HomeEvent>(
      (event, emit) async {
        if (event is _init) {
          await _emitInit(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  Future<void> _emitInit(
    _init event,
    Emitter<HomeState> emit,
  ) async {}
}

