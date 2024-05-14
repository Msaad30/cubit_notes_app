import 'dart:developer';

import 'package:cubit_notes_app/cubit/note_cubit.dart';
import 'package:cubit_notes_app/cubit/note_state.dart';
import 'package:cubit_notes_app/cubit/note_state.dart';
import 'package:cubit_notes_app/cubit/note_state.dart';
import 'package:cubit_notes_app/database/db_helper.dart';
import 'package:cubit_notes_app/models/note_model.dart';
import 'package:cubit_notes_app/screens/add_notes.dart';
import 'package:cubit_notes_app/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/note_state.dart';
import '../cubit/note_state.dart';

class ListNotes extends StatefulWidget {
  const ListNotes({super.key});

  @override
  State<ListNotes> createState() => _ListNotesState();
}

class _ListNotesState extends State<ListNotes> {

  @override
  void initState() {
    super.initState();
    context.read<NoteCubit>().getAllNote();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<NoteCubit,NoteState>(
        builder: (context,state) {
          if(state is LoadingState){
            return CircularProgressIndicator();
          } else if(state is LoadedState) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var data = state.arrayNote[index];
                return ListTile(
                  leading: Text("${index+1}"),
                  title: Text(data.title.toString()),
                  subtitle: Text(data.desc.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: (){
                            showBottomSheet(
                                context: context,
                              builder: (BuildContext context) {
                                  titleController.text = state.arrayNote[index].title;
                                  descController.text = state.arrayNote[index].desc;
                                  return Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                          UiHelper.customBtn(() {
                                            context.read<NoteCubit>().updateNote(
                                                NoteModel(
                                                    id: state.arrayNote[index].id!.toInt(),
                                                    title: titleController.text.toString(),
                                                    desc: descController.text.toString()
                                                )
                                            );
                                            log("Data Updated");
                                            Navigator.pop(context);
                                          }, btnText: "update"),
                                        ],
                                      ),
                                    ),
                                  );
                              },
                            );
                          },
                          icon: Icon(Icons.edit)
                      ),
                      IconButton(
                          onPressed: (){
                            context.read<NoteCubit>().deleteNote(data.id!.toInt());
                          },
                          icon: Icon(Icons.delete),
                      )
                    ],
                  ),
                );
              },itemCount: state.arrayNote.length,
            );
          } else if(state is ErrorState){
            return Center(
                child: Text(state.errorMsg.toString())
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigator(AddNotes());
        },
        child: Icon(Icons.add_box),
      ),
    );
  }
  navigator(page){
    Navigator.push(context, MaterialPageRoute(builder: (_)=>page));
  }
}