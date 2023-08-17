part of 'home_bloc.dart';

@freezed
abstract class HomeEvent with _$HomeEvent {
  factory HomeEvent.init() = _init;
}
