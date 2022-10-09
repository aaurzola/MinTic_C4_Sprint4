import 'package:geolocator/geolocator.dart';


class GpsSensor {
  Future<LocationPermission> get permissionStatus async => await Geolocator.checkPermission();// Usando GeoLocator verifica el estado de los permisos

  Future<Position> get currentLocation async => await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);// Usando GeoLocator obten la posicion actual

  Future<LocationAccuracyStatus> get locationAccuracy async => await Geolocator.getLocationAccuracy();// Usando GeoLocator verifica la precision de la ubicacion con soporte para web

  Future<LocationPermission> requestPermission() async {
    return Geolocator.requestPermission();
  }
}
