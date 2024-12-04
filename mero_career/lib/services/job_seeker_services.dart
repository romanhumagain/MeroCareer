import 'package:http/http.dart' as http;
import 'dart:convert';

class JobSeekerServices{
  final String baseURL = 'http://10.0.2.2:8000/api';

Future<http.Response> registerUser(Map<String , dynamic> jobSeekerData) async{
  try{
    final response = await http.post(
      Uri.parse('$baseURL/jobseeker/register/'),
      headers: {
        'Content-Type':'application/json'
      },
      body: json.encode(jobSeekerData)
    );
    return response;
  }
  catch (e){
    throw Exception('Error during job seeker registration $e');
  }
}
  

}