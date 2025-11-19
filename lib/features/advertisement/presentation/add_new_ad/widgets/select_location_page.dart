import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/cubit/cubit.dart';

class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({
    super.key,
  });

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Marker marker = const Marker(
    markerId: MarkerId('selected_location'),
    position: LatLng(37.42796133580664, -122.085749655962),
    infoWindow: InfoWindow(title: 'Selected Location'),
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.terrain,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: _controller.complete,
      myLocationEnabled: true,
      markers: {marker},
      onTap: (location) {
        setState(() {
          context.read<AddNewAdCubit>().changeAdRequest(
                context.read<AddNewAdCubit>().state.addAdRequest.copyWith(
                      latitude: location.latitude,
                      longitude: location.longitude,
                    ),
              );
          marker = marker.copyWith(
            positionParam: location,
          );
        });
      },
      gestureRecognizers: const {
        Factory<OneSequenceGestureRecognizer>(
          EagerGestureRecognizer.new,
        ),
      },
    );
  }

  Future<void> getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final lat = position.latitude;
    final long = position.longitude;

    final location = LatLng(lat, long);

    await _controller.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: location,
            zoom: 15,
          ),
        ),
      );
    });
  }
}
