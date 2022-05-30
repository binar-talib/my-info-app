import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'models/job.dart';

class Jobs {
  List<Job> allJobs = [];
  Future<List<Job>> getAllJobs() async {
    http.Response response = await http.get(
      Uri.parse('https://tory-kar-1.herokuapp.com/api/v1/jobs'),
    );
    if (response.statusCode == 200) {
      var decodedJson = convert.jsonDecode(response.body);
      var data = decodedJson['data'];
      for (int i = 0; i < data.length; i++) {
        allJobs.add(Job.fromJson(data[i]));
      }
    } else {
      throw Exception('Failed to load Jobs');
    }
    return allJobs;
  }
}
