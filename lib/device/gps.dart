import 'package:geolocator/geolocator.dart';


class GpsSensor {
  Future<LocationPermission> get permissionStatus async => await Geolocator.checkPermission();// Usando GeoLocator verifica el estado de los permisos

  Future<Position> get currentLocation async => await Geolocator.getCurrentPosition();// Usando GeoLocator obten la posicion actual

  Future<LocationAccuracyStatus> get locationAccuracy async => await Geolocator.getLocationAccuracy();// Usando GeoLocator verifica la precision de la ubicacion con soporte para web

  Future<LocationPermission> requestPermission() async {
    // TO-DO: Debes configurar correctamente el AndroidManifest.xml para Android:
    // 1. <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    // 2. <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

    // TO-DO: Si usas iOS debes configurar el Info.plist usando Xcode
    // 1. <key>NSLocationWhenInUseUsageDescription</key>
    //    <string>Esta aplicación necesita acceso a la ubicación cuando está abierta.</string>
    // 2. <key>NSLocationAlwaysUsageDescription</key>
    //    <string>Esta aplicación necesita acceso a la ubicación cuando está en segundo plano.</string>

    // TO-DO: Usando GeoLocator solicita los permisos
    return Geolocator.requestPermission();
  }
}
