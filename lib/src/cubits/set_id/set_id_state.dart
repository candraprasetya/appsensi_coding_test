part of 'set_id_cubit.dart';

@immutable
abstract class SetIdState {}

class SetIdInitial extends SetIdState {}

class IdSet extends SetIdState {
  final int id;

  IdSet(this.id);
}
