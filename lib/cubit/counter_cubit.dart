import 'package:cubit_notes_app/cubit/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState>{
  CounterCubit() : super(CounterState(counterValue: 0));
  increment(){
    emit(CounterState(counterValue: state.counterValue + 1));
  }
}