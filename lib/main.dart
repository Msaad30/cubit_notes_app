import 'package:cubit_notes_app/cubit/note_cubit.dart';
import 'package:cubit_notes_app/screens/add_notes.dart';
import 'package:cubit_notes_app/screens/list_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'database/db_helper.dart';
import 'screens/counter_app_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NoteCubit(db: DbHelper.dbHelper),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ListNotes(),
      ),
    );
  }
}

