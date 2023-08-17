part of 'home_bloc.dart';

@freezed
abstract class HomeState with _$HomeState {
  factory HomeState.state({
    @Default(EnumStatus.initial) EnumStatus status,
    @Default("") String message,
  }) = _state;
}

enum EnumStatus { initial, loading, fail, success }
