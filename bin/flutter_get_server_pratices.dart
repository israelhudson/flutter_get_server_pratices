import 'package:get_server/get_server.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();

  runApp(
    GetServer(
      home: Home(),
    ),
  );
}


class Home extends StatelessWidget {
  var map = Map();
  @override
  Widget build(BuildContext context) {
    print("AI DENTO");
    banco();

    return Json({
      "fruits": ["banana", "apple", "orange"]
    });
  }

  Future<String> banco() async {
  // Init ffi loader if needed.
  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;
  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
  await db.execute('''
  CREATE TABLE Product (
      id INTEGER PRIMARY KEY,
      title TEXT
  )
  ''');
  await db.insert('Product', <String, dynamic>{'title': 'Product 1'});
  await db.insert('Product', <String, dynamic>{'title': 'Product 1'});

  var result = await db.query('Product');
  print(result);
  // prints [{id: 1, title: Product 1}, {id: 2, title: Product 1}]
  await db.close();
}
}