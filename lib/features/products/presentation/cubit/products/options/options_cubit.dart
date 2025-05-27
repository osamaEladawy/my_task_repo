import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'options_state.dart';

class SharedCubit extends Cubit<SharedState> {
  SharedCubit() : super(OptionsInitial());

  final String sortBy = 'title';
  bool isValue = true;
  bool isFilter = false;
  String order = 'asc';

  void isFiltering(bool filter) {
    isFilter = filter;
    emit(IsFileting(isFilter: isFilter));
  }

  void isSelectedCheckBox(bool isSelect) {
    isValue = isSelect;
    emit(SelectCheckBox(isSelect: isValue));
  }

  void selectedRole(String title) {
    order = title;
    emit(SelectOrder(title: order));
  }
}
