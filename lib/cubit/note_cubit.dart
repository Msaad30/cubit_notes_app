import 'package:cubit_notes_app/cubit/note_state.dart';
import 'package:cubit_notes_app/database/db_helper.dart';
import 'package:cubit_notes_app/models/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteCubit extends Cubit<NoteState>{
  DbHelper db;
  NoteCubit({required this.db}) : super(InitState());

  addNote(NoteModel noteModel) async {
    emit(LoadingState());
    bool check = await DbHelper().insert(noteModel);
    if(check){
      var note = await db.fetch();
      emit(LoadedState(arrayNote: note));
    } else {
      emit(ErrorState(errorMsg: "data not found"));
    }
  }

  void getAllNote() async {
    emit(LoadingState());
    var note = await db.fetch();
    emit(LoadedState(arrayNote: note));
  }

  deleteNote(int id) async {
    emit(LoadingState());
    var check = await db.deleteData(id);
    if(check){
      var note = await db.fetch();
      emit(LoadedState(arrayNote: note));
    } else {
      emit(ErrorState(errorMsg: "data not deleted"));
    }
  }

  updateNote(NoteModel noteModel) async {
    emit(LoadingState());
    bool check = await db.updateData(noteModel);
    if(check){
      var note = await db.fetch();
      emit(LoadedState(arrayNote: note));
    } else {
      emit(ErrorState(errorMsg: "data not found"));
    }
  }
}
