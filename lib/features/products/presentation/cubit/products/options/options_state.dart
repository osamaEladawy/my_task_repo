part of 'options_cubit.dart';

sealed class SharedState extends Equatable {
  const SharedState();

  @override
  List<Object> get props => [];
}

final class OptionsInitial extends SharedState {}

final class IsFileting extends SharedState {
  final bool isFilter;

  const IsFileting({required this.isFilter});
   @override
  List<Object> get props => [isFilter];
}


final class SelectOrder extends SharedState {
  final String title;

  const SelectOrder({required this.title});
  @override
  List<Object> get props => [title];
}

final class SelectCheckBox extends SharedState {
  final bool isSelect;

  const SelectCheckBox({required this.isSelect});
  @override
  List<Object> get props => [isSelect];
}
