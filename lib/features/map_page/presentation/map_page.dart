// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:konar_mobile/features/map_page/presentation/widgets/osm_widget.dart';

class MapPage extends ConsumerStatefulWidget {

  const MapPage({
    super.key,
  });

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  Position? position;
  LocationPermission? permission;

  @override
  void initState() {
    getCurPos();
    super.initState();
  }

  Future<Position> getCurPos() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return position = await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Карта')),
      body: FutureBuilder<Position>(
          future: getCurPos(),
          builder: (context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.hasData) {
              //55.145486
              //61.4778714
              return OsmWidget(lat: position!.latitude,long: position!.longitude,);
            }
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Подождите...\nКарта загружается'),
                  SizedBox(
                    height: 8,
                  ),
                  CircularProgressIndicator(
                    color: Color(0xff0D1F61),
                    strokeWidth: 2,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
