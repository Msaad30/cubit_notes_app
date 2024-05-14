import 'package:cubit_notes_app/cubit/counter_cubit.dart';
import 'package:cubit_notes_app/cubit/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CounterCubit, CounterState>(
        builder: (BuildContext context, state) {
          return Center(
            child: Text(state.counterValue.toString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterCubit>().increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
