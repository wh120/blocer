import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'blocer_state.dart';

abstract class BlocerCubit extends Cubit<BlocerState> {
  BlocerCubit() : super(BlocerInitial());

}
