import 'package:f_gps_tracker/domain/models/location.dart';
import 'package:f_gps_tracker/ui/controllers/gps.dart';
import 'package:f_gps_tracker/ui/controllers/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentPage extends GetView<LocationController> {
  late final GpsController gpsController = Get.find();

  ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GPS Tracker"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: controller.getAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        Position position = await gpsController.currentLocation;
                        LocationAccuracyStatus precision =
                            await gpsController.locationAccuracy;
                        TrackedLocation userLocation = TrackedLocation(
                            latitude: position.latitude,
                            longitude: position.longitude,
                            precision: precision.name,
                            timestamp: DateTime.now());
                        controller.saveLocation(location: userLocation);
                      },
                      child: const Text("Registrar Ubicacion"),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView.separated(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: controller.locations.length,
                        itemBuilder: (context, index) {
                          final location = controller.locations[index];
                          return Card(
                            child: ListTile(
                              isThreeLine: true,
                              leading: IconButton(
                                icon: const Icon(
                                  Icons.map,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  _launchURL(
                                      location.latitude, location.longitude);
                                },
                              ),
                              title: Text(
                                  '${location.latitude}, ${location.longitude}'),
                              subtitle: Text(
                                  'Fecha: ${location.timestamp.toIso8601String()}\n${location.precision.toUpperCase()}'),
                              trailing: IconButton(
                                onPressed: () {
                                  controller.deleteLocation(location: location);
                                },
                                icon: const Icon(
                                  Icons.delete_forever_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 8.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        controller.deleteAll();
                      },
                      child: const Text("Eliminar Ubicaciones guardadas"),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  _launchURL(double latitud, double longitud) async {
    Uri url = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$latitud%2C$longitud");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
