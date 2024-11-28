import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CompanyMapScreen extends StatefulWidget {
  final String companyAddress;
  final String companyName;

  const CompanyMapScreen(
      {super.key, required this.companyAddress, required this.companyName});

  @override
  State<CompanyMapScreen> createState() => _CompanyMapScreenState();
}

class _CompanyMapScreenState extends State<CompanyMapScreen> {
  LatLng? _companyLocationCoordinates;

  bool _isLoading = true;

  Future<Map<String, dynamic>> getCoordinates() async {
    final url = Uri.parse(
        "http://api.positionstack.com/v1/forward?access_key=1557c80d9c180672226c52056a37edf5&query=${widget.companyAddress}, Nepal");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['data'].isNotEmpty) {
        final locationData = data["data"][0];
        return {
          "lat": locationData["latitude"],
          "lng": locationData["longitude"]
        };
      } else {
        throw Exception("No results found for the given location.");
      }
    } else {
      throw Exception("Failed to fetch coordinates: ${response.reasonPhrase}");
    }
  }

  void fetchCoordinates() async {
    try {
      final coords = await getCoordinates();
      setState(() {
        _companyLocationCoordinates = LatLng(coords['lat'], coords['lng']);
        _isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCoordinates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Text("Location of ${widget.companyName}"),
        ),
        body: _isLoading
            ? Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                  size: 35,
                  color: Colors.blue,
                ),
              )
            : (_companyLocationCoordinates != null
                ? GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: _companyLocationCoordinates!, zoom: 15),
                    markers: {
                      Marker(
                        markerId: MarkerId("_companyLocation"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: _companyLocationCoordinates!,
                        infoWindow: InfoWindow(
                          title: widget.companyName,
                          snippet: "Company Location",
                        ),
                      )
                    },
                  )
                : Center(child: Text("Failed to load location"))));
  }
}
