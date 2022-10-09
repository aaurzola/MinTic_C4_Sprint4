import 'package:f_gps_tracker/domain/models/location.dart';
import 'package:f_gps_tracker/domain/use_cases/location_manager.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final Rx<List<TrackedLocation>> _locations = Rx([]);

  List<TrackedLocation> get locations => _locations.value;

  Future<void> initialize() async {
    await LocationManager.initialize();
  }

  Future<void> saveLocation({
    required TrackedLocation location,
  }) async {
    /* TO-DO: Usa [LocationManager] para guardar [save] la ubicacion [location] */
    await LocationManager.save(location: location);
    _locations.update((_) => _locations.value.add(location));
  }

  Future<List<TrackedLocation>> getAll({
    String? orderBy,
  }) async {
    /* TO-DO: Usa [getAll] de [LocationManager] para obtener la lista de ubicaciones guardadas y retornalas */
    return LocationManager.getAll();
  }

  Future<void> updateLocation({required TrackedLocation location}) async {
    /* TO-DO: Usa [LocationManager.update] para actualizar la ubicacion y luego obten todas las ubicaciones de nuevo */
    LocationManager.update(location: location);
    _locations.update((val) => val);
  }

  Future<void> deleteLocation({required TrackedLocation location}) async {
    /* TO-DO: Con [LocationManager.delete] elimina la ubicacion y luego usa [removeWhere] para eliminar la ubicacion de [_locations.value] usando [_locations.update de GetX] */
    LocationManager.delete(location: location);
    _locations.update((val) {
      val?.removeWhere((element) => element == location);
    });

  }

  Future<void> deleteAll() async {
    /* TO-DO: Con [LocationManager.deleteAll] elimina todas las ubicaciones guardas y asigna una lista vacia a [_locations.value] */
    LocationManager.deleteAll();
    _locations.value = [];
  }
}
