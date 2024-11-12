import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert'; // For JSON encoding/decoding

class QuizDatabaseHelper {
  static Database? _database;

  // Initialize the database
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'quiz_attempt.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create the table
  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE quiz_attempt (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        quizId INTEGER,
        answers TEXT
      )
    ''');
  }

/*
  // Insert a quiz attempt with quizId and answers as JSON
  static Future<int> insertAttempt(int quizId, Map<int, String> answers) async {
    Database db = await database;

    // Convert to Map<String, dynamic>
    Map<String, dynamic> convertedAnswers = answers.map((key, value) {
      // Convert key to String and keep the value as is
      return MapEntry(key.toString(), value);
    });
    print("convertedAnswers : $convertedAnswers");
    String answersJson =
        jsonEncode(convertedAnswers); // Serialize answers map to JSON string
    print("jsonAnswer : $answersJson");
    Map<String, dynamic> quizAttempt = {
      'quizId': quizId,
      'answers': answersJson,
    };
    return await db.insert('quiz_attempt', quizAttempt);
  }
*/
  static Future<int> insertOrUpdateAttempt(int quizId, Map<int, String> answers) async {
    Database db = await database;

    // Convert to Map<String, dynamic>
    Map<String, dynamic> convertedAnswers = answers.map((key, value) {
      // Convert key to String and keep the value as is
      return MapEntry(key.toString(), value);
    });
    print("convertedAnswers : $convertedAnswers");

    String answersJson = jsonEncode(convertedAnswers); // Serialize answers map to JSON string
    print("jsonAnswer : $answersJson");

    // Check if the quizId already exists
    List<Map<String, dynamic>> existingAttempts = await db.query(
      'quiz_attempt',
      where: 'quizId = ?',
      whereArgs: [quizId],
    );

    Map<String, dynamic> quizAttempt = {
      'quizId': quizId,
      'answers': answersJson,
    };

    if (existingAttempts.isNotEmpty) {
      // Update the existing attempt
      print('Quiz attempt already exists, updating...');
      return await db.update(
        'quiz_attempt',
        quizAttempt,
        where: 'quizId = ?',
        whereArgs: [quizId],
      );
    } else {
      // Insert a new attempt
      print('Quiz attempt not found, inserting...');
      return await db.insert('quiz_attempt', quizAttempt);
    }
  }

  // Get all quiz attempts
  static Future<List<Map<String, dynamic>>> getAttempts() async {
    Database db = await database;
    return await db.query('quiz_attempt');
  }

  // Update quiz attempt
  static Future<int> updateAttempt(
      int id, int quizId, Map<int, String> answers) async {
    Database db = await database;
    String answersJson =
        jsonEncode(answers); // Serialize answers map to JSON string
    Map<String, dynamic> updatedAttempt = {
      'quizId': quizId,
      'answers': answersJson,
    };
    return await db.update('quiz_attempt', updatedAttempt,
        where: 'id = ?', whereArgs: [id]);
  }

  // Delete quiz attempt
  static Future<int> deleteAttempt(int id) async {
    Database db = await database;
    return await db.delete('quiz_attempt', where: 'id = ?', whereArgs: [id]);
  }

  // Decode JSON answers when fetching attempts
  static Future<List<Map<String, dynamic>>>
      getAttemptsWithDecodedAnswers() async {
    Database db = await database;
    List<Map<String, dynamic>> attempts = await db.query('quiz_attempt');

    // Decode answers field from JSON to map
    List<Map<String, dynamic>> decodedAttempts = attempts.map((attempt) {
      attempt['answers'] =
          jsonDecode(attempt['answers']); // Deserialize JSON string to map
      return attempt;
    }).toList();

    return decodedAttempts;
  }

  // Get quiz attempt by ID
  static Future<Map<String, dynamic>?> getAttemptById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> attempts = await db.query(
      'quiz_attempt',
      where: 'quizId = ?',
      whereArgs: [id],
    );
    // print("attempts=> ${attempts[0]['answers']}");
    if (attempts.isNotEmpty) {
      // Decode answers field from JSON to map
      return json.decode((attempts[0]
          ['answers'])); // Return the first (and should be only) match
    }
    return null; // Return null if no attempt found
  }
}
