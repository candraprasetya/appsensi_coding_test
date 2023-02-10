import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'set_id_state.dart';

class SetIdCubit extends Cubit<SetIdState> {
  SetIdCubit() : super(SetIdInitial());

  void setId(int id) {
    emit(IdSet(id));
  }
}
