part of 'roles_cubit.dart';

abstract class RolesState extends Equatable {
  const RolesState();

  @override
  List<Object> get props => [];
}

class RolesInitial extends RolesState {}

class SelectRole extends RolesState {
  final int role;

  const SelectRole({required this.role});
  @override
  List<Object> get props => [role];
}
