import 'package:google_maps_flutter/google_maps_flutter.dart';

class Delivery {
  String name;
  String subLocality;
  String locality;
  String administrativeArea;
  String postalCode;
  String country;
  LatLng latlng;
  Delivery(this.name, this.subLocality, this.locality, this.administrativeArea,
      this.postalCode,this.country, this.latlng);
}
