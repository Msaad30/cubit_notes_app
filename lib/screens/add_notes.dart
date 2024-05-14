import 'dart:developer';

import 'package:cubit_notes_app/cubit/note_cubit.dart';
import 'package:cubit_notes_app/database/db_helper.dart';
import 'package:cubit_notes_app/models/note_model.dart';
import 'package:cubit_notes_app/screens/list_note.dart';
import 'package:cubit_notes_app/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

  late DbHelper mydb;

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            UiHelper.customTextField(
                controller: titleController,
                hintText: "enter title",
                icon: Icons.text_fields_outlined
            ),
            UiHelper.customTextField(
              controller: descController,
              hintText: "enter desc",
              icon: Icons.description,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UiHelper.customBtn(() {
                  titleController.text = "";
                  descController.text = "";
                }, btnText: "clear"),
                UiHelper.customBtn(() {
                    context.read<NoteCubit>().addNote(
                        NoteModel(
                            title: titleController.text.toString(),
                            desc: descController.text.toString()
                        )
                    );
                    log("Data added");
                }, btnText: "insert"),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ListNotes()));
        },
        child: Icon(Icons.list),
      ),
    );
  }
}