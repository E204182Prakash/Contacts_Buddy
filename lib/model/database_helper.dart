import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_contact_app/model/contact_model.dart';


class DatabaseHelper {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'contactsBuddy.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE	TABLE	contacts(id	INTEGER	PRIMARY	KEY	AUTOINCREMENT,	name	TEXT	NO NULL, phoneNumber INTEGER NOT NULL, email TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertContact(List<Contact>contacts) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var contact in contacts) {
      result = await db.insert('contacts', contact.toMap());
    }
    return result;
  }

  Future<List<Contact>> retrieveContact() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('contacts');
    return queryResult.map((e) => Contact.fromMap(e)).toList();
  }

  Future<void> deleteContact(int id) async {
    final db = await initializeDB();
    await db.delete(
      'contacts',
      where: "id	=	?",
      whereArgs: [id],
    );
  }

  Future<int> updateContact(List<Contact>contacts) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var contact in contacts) {
      result = await db.update('contacts',
          contact.toMap(),
          where: 'id = ?',
          whereArgs: [contact.id]
      );
    }
    return result;
  }

}


