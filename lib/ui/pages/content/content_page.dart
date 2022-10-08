import 'package:f_gps_tracker/domain/models/location.dart';
import 'package:f_gps_tracker/ui/controllers/gps.dart';
import 'package:f_gps_tracker/ui/controllers/location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                        // TO-DO: 1. Obten la ubicacion actual con gpsController.currentLocation
                        // await gpsController.currentLocation;
                        // TO-DO: 2. Obten la precision de la lectura con gpsController.locationAccuracy.
                        // await gpsController.accuracy;
                        // TO-DO: 3. Crea un objeto [TrackedLocation] con fecha actual [DateTime.now] y la precision como texto [accuracy.name]
                        TrackedLocation userLocation = TrackedLocation(
                            latitude: gpsController.location!.latitude,
                            longitude: gpsController.location!.longitude,
                            precision: gpsController.accuracy.toString(),
                            timestamp: DateTime.now());
                        // TO-DO: 4. con el [controller] guarda ese objeto [saveLocation]
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
                              leading: Icon(
                                Icons.gps_fixed_rounded,
                                color: Colors.amber[300],
                              ),
                              title: Text(
                                  '${location.latitude}, ${location.longitude}'),
                              subtitle: Text(
                                  'Fecha: ${location.timestamp.toIso8601String()}\n${location.precision.toUpperCase()}'),
                              trailing: IconButton(
                                onPressed: () {
                                  // TO-DO: elimina la ubicacion [location] usando el controlador [deleteLocation]
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
                        // TO-DO: elimina todas las ubicaciones usando el controlador [deleteAll]
                        await controller.deleteAll();
                      },
                      child: const Text("Eliminar Todos"),
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
}
