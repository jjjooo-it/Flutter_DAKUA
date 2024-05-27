import 'package:mobileplatform_project/dbHelper/user_dbHelper.dart';
import 'package:mobileplatform_project/model/user.dart';
import 'package:http/http.dart' as http;

class UserDataSource {
  final String baseUrl;

  UserDataSource(this.baseUrl);

  Future<void> insertUser(User user) async {
    await DBHelper.insertUser(user);
  }

  Future<Map<String, dynamic>> postUserId(String userId) async {
    print("User_initial api call  $userId");

    final response = await http.post(
      Uri.parse('$baseUrl/User_initial/?user_id=$userId'),
    );
    print(response);

    if (response.statusCode == 200) {
      return {'status': 'success', 'message': 'User initialized successfully'};
    } else {
      return {'status': 'error', 'message': 'Failed to initialize user: ${response.statusCode}'};
    }
  }
}
