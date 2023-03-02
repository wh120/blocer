part of 'blocer_cubit.dart';

@immutable
abstract class BlocerState {}

class BlocerInitial extends BlocerState {}
class BlocerLoading extends BlocerState {}
class BlocerError extends BlocerState {
  final  error;

  BlocerError({required this.error});
}
class BlocerLoaded  extends BlocerState {
  final   data ;

  BlocerLoaded({required this.data});

}
