import 'package:cubit_notes_app/models/note_model.dart';

abstract class NoteState{}
class InitState extends NoteState{}
class LoadingState extends NoteState{}
class LoadedState extends NoteState{
  List<NoteModel> arrayNote = [];
  LoadedState({required this.arrayNote});
}
class ErrorState extends NoteState{
  String errorMsg;
  ErrorState({required this.errorMsg});
}
