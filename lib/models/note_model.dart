import 'package:cubit_notes_app/database/db_helper.dart';

class NoteModel{
  int? id;
  String title;
  String desc;

  NoteModel({
    this.id,
    required this.title,
    required this.desc
  });

  Map<String, dynamic> toMap(){
    return {

      DbHelper.id : id,
      DbHelper.title : title,
      DbHelper.desc : desc,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> mapData){
    return NoteModel(
      id: mapData[DbHelper.id],
      title: mapData[DbHelper.title],
      desc: mapData[DbHelper.desc],
    );
  }
}