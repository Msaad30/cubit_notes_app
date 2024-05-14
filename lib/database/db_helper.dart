import 'package:cubit_notes_app/models/note_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  static final DbHelper dbHelper = DbHelper();

  static const String database = "notes.db";
  static const String table = "notes_table";
  static const String id = "notes_id";
  static const String title = "notes_title";
  static const String desc = "notes_desc";
  Database? _db;

  Future<Database> getDb() async {
    if(_db != null){
      return _db!;
    } else {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    var directory = await getApplicationDocumentsDirectory();
    await directory.create(recursive: true);
    var path = directory.path + database;
    return openDatabase(path, version: 1, onCreate: (db, version){
      db.execute("create table $table ($id integer primary key autoincrement, $title text, $desc text)");
    });
  }

  Future<bool>insert(NoteModel) async {
    var db = await getDb();
    int row = await db.insert(table, NoteModel.toMap());
    return row > 0;
  }

  Future<List<NoteModel>>fetch()async{
    var db = await getDb();
    List<Map<String, dynamic>> notesData = await db.query(table);
    List<NoteModel> listNotes = [];
    for(Map<String, dynamic> notes in notesData){
      NoteModel noteModel = NoteModel.fromMap(notes);
      listNotes.add(noteModel);
    }
    return listNotes;
  }

  Future<bool> updateData(NoteModel noteModel) async {
    var db = await getDb();
    var count = await db.update(table, noteModel.toMap(), where: "$id = ${noteModel.id}" );
    return count > 0;
  }

  Future<bool> deleteData(int noteId) async {
    var db = await getDb();
    var count1 = await db.delete(table, where: "$id = ?", whereArgs: [noteId.toInt()]);
    return count1 > 0;
  }
}