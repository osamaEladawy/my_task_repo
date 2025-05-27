part of 'home_tap_cubit.dart';

abstract class HomeTapState extends Equatable {
  const HomeTapState();

  @override
  List<Object> get props => [];
}

class HomeTapInitial extends HomeTapState {}

final class SelectPage extends HomeTapState {
  final int index;
  const SelectPage({required this.index});
  @override
  List<Object> get props => [index];
}
