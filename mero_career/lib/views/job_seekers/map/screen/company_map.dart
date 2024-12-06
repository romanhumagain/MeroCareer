import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CompanyMap extends StatelessWidget {
  final String apiKey =
      "09fa90be675b4c0a8194a8443531ca20";

  const CompanyMap({super.key}); // Replace with your API key

  Future<Map<String, dynamic>> getCoordinates(String location) async {
    final url = Uri.parse(
        "https://api.opencagedata.com/geocode/v1/json?q=Kathmandu,%20Nepal&key=09fa90be675b4c0a8194a8443531ca20");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["results"].isNotEmpty) {
        final locationData = data["results"][0]["geometry"];
        return {"lat": locationData["lat"], "lng": locationData["lng"]};
      } else {
        throw Exception("No results found for the given location.");
      }
    } else {
      throw Exception("Failed to fetch coordinates: ${response.reasonPhrase}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OpenCage Geocoder Example"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            const location = "Kathmandu, Nepal";
            try {
              final coords = await getCoordinates(location);
              print("Latitude: ${coords['lat']}, Longitude: ${coords['lng']}");
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Coordinates for Kathmandu"),
                  content: Text(
                      "Latitude: ${coords['lat']}, Longitude: ${coords['lng']}"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"),
                    ),
                  ],
                ),
              );
            } catch (e) {
              print("Error: $e");
            }
          },
          child: Text("Get Coordinates for Kathmandu"),
        ),
      ),
    );
  }
}
