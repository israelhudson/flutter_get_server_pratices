import 'package:get_server/get_server.dart';
import 'package:mysql1/mysql1.dart';
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
    connMysql();

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

Future connMysql() async {
  // Open a connection (testdb should already exist)
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'localhost', port: 3306, user: 'root', db: 'test'));

  // Create a table
  // await conn.query(
  //     'CREATE TABLE users (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, name varchar(255), email varchar(255), age int)');

  // // Insert some data
  // var result = await conn.query(
  //     'insert into users (name, email, age) values (?, ?, ?)',
  //     ['Bob', 'bob@bob.com', 25]);
  // print('Inserted row id=${result.insertId}');

  // Query the database using a parameterized query
  var results = await conn
      .query('select nome from pessoa');
  for (var row in results) {
    print('Name: ${row[0]}');
  }

  // Finally, close the connection
  await conn.close();
}
}