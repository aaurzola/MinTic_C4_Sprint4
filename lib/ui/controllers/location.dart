import 'package:f_gps_tracker/domain/models/location.dart';
import 'package:f_gps_tracker/domain/use_cases/location_manager.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final Rx<List<TrackedLocation>> _locations = Rx([]);

  List<TrackedLocation> get locations => _locations.value;

  Future<void> initialize() async {
    await LocationManager.initialize();
    _locations.value = await LocationManager.getAll();
  }

  Future<void> saveLocation({
    required TrackedLocation location,
  }) async {
    await LocationManager.save(location: location);
    _locations.update((_)=> _locations.value.add(location));
  }


  Future<List<TrackedLocation>> getAll({
    String? orderBy,
  }) async {
    return LocationManager.getAll();
  }

  Future<void> updateLocation({required TrackedLocation location}) async {
    LocationManager.update(location: location);
    _locations.update((val) => val);
  }

  Future<void> deleteLocation({required TrackedLocation location}) async {
    LocationManager.delete(location: location);
    _locations.update((val) {
      val?.removeWhere((element) => element == location);
    });

  }

  Future<void> deleteAll() async {
    LocationManager.deleteAll();
    _locations.value = [];
  }
}
