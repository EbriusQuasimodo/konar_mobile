// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:konar_mobile/features/main_page/presentation/map_controller.dart';
import 'package:konar_mobile/features/map_page/presentation/widgets/whatsViewChipWidget.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends ConsumerStatefulWidget {
  String? lat;
  String? long;
  String? whatsView;

  MapPage({
    super.key,
    this.lat,
    this.long,
    this.whatsView,
  });

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  Position? position;
  LocationPermission? permission;
  List<Marker> allMarkers = [];
  int markerId = -1;
  late String whatsView;
  late List<double> lat;
  late List<double> long;

  List<String> whatsViewSelectedList = [];
  List<String> whatsViewAllList = [
    'Столовая',
    'Мед. пункт',
    'Тренажерный зал',
    'кпп'
  ];
  List<IconData?> whatsViewAllIconsList = [
    Icons.lunch_dining_outlined,
    Icons.local_hospital_outlined,
    Icons.fitness_center,
    null
  ];

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

  void addCurrentPositionMarker() {
    allMarkers.add(
      const Marker(
          width: 40.0,
          height: 40.0,
          point: LatLng(55.145486, 61.4778714),
          child: Icon(
            Icons.person,
          )),
    );
  }

  void addAllMarkers(String whatsView, IconData? icon) {
    for (var i = 0; i < lat.length; i++) {
      allMarkers.add(
        Marker(
          point: LatLng(lat[i], long[i]),
          height: 40,
          width: 40,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  barrierColor: Colors.white.withOpacity(0),
                  constraints: const BoxConstraints(
                      maxHeight: 250,
                      minHeight: 200,
                      minWidth: double.infinity),
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Text(
                        '$whatsView ${i + 1}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).whenComplete(() {
                setState(() {
                  markerId = -1;
                });
              });
              setState(() {
                markerId = i;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: markerId == i ? const Color(0xff0D1F61) : Colors.white,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(40),
                  child: icon != null
                      ? Icon(
                          icon,
                          color: markerId == i
                              ? Colors.white
                              : const Color(0xff0D1F61),
                          size: markerId == i ? 30 : 20,
                        )
                      : Center(
                        child: Text(
                            whatsView,
                            style: TextStyle(
                                color: markerId == i
                                    ? Colors.white
                                    : const Color(0xff0D1F61),
                                fontSize: 20, fontWeight: markerId == i ? FontWeight.w600 : FontWeight.w500),
                          ),
                      ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void deleteAllMarkers() {
    allMarkers.clear();
  }

  @override
  Widget build(BuildContext context) {
    whatsView = ref.watch(whatsViewOnMapStateProvider);
    lat = ref.watch(latitudeListOnMapStateProvider);
    long = ref.watch(longitudeListOnMapStateProvider);

    switch (whatsView) {
      case 'Столовая':
        deleteAllMarkers();
        addCurrentPositionMarker();
        addAllMarkers(whatsView, Icons.lunch_dining_outlined);
        break;
      case 'Мед. пункт':
        deleteAllMarkers();
        addCurrentPositionMarker();
        addAllMarkers(whatsView, Icons.local_hospital_outlined);
        break;
      case 'Тренажерный зал':
        deleteAllMarkers();
        addCurrentPositionMarker();
        addAllMarkers(whatsView, Icons.fitness_center);
        break;
      case 'кпп':
        deleteAllMarkers();
        addCurrentPositionMarker();
        addAllMarkers(whatsView, null);
        break;
      case '':
        deleteAllMarkers();
        addCurrentPositionMarker();
    }
    print(whatsView);
    return Scaffold(
      appBar: AppBar(title: const Text('Карта')),
      body: FutureBuilder<Position>(
          future: getCurPos(),
          builder: (context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.hasData) {
              //55.145486
              //61.4778714
              return Column(
                children: [
                  Flexible(
                    child: FlutterMap(
                      options: const MapOptions(
                        initialCenter: LatLng(55.145486, 61.4778714),
                        initialZoom: 15,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: const ['a', 'b', 'c'],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13, right: 13),
                          child: Wrap(
                            children: List.generate(4, (index) {
                              // if(whatsView!=''){
                              whatsViewSelectedList.clear();
                              whatsViewSelectedList.add(whatsView);
                              // }
                              return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 6, right: 6),
                                  child: WhatsViewChipWidget(
                                    icon: whatsViewAllIconsList[index],
                                    itemName: whatsViewAllList[index],
                                    filters: whatsViewSelectedList,
                                  ));
                            }).toList(),
                          ),
                        ),
                        MarkerLayer(markers: allMarkers),
                      ],
                    ),
                  ),
                ],
              );
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

// Container(
//   margin: const EdgeInsets.symmetric(vertical: 16),
//   child: MaterialButton(
//     onPressed: () {
//       setState(() {
//         ref
//             .watch(whatsViewOnMapStateProvider.notifier)
//             .state = '';
//         ref
//             .watch(
//             longitudeListOnMapStateProvider.notifier)
//             .state = [];
//         ref
//             .watch(
//             latitudeListOnMapStateProvider.notifier)
//             .state = [];
//       });
//       ref
//           .watch(whatsViewOnMapStateProvider.notifier)
//           .state = 'Столовая';
//       ref
//           .watch(
//               longitudeListOnMapStateProvider.notifier)
//           .state = [61.4749, 61.48474, 61.45938];
//       ref
//           .watch(
//               latitudeListOnMapStateProvider.notifier)
//           .state = [55.1443, 55.14536, 55.14645];
//     },
//     shape: const CircleBorder(),
//     color: whatsView == 'Столовая'
//         ? Color(0xff0D1F61)
//         : Colors.white,
//     child: Icon(
//       Icons.lunch_dining_outlined,
//       color: whatsView =='Столовая'
//           ? Colors.white
//           : Color(0xff0D1F61),
//     ),
//   ),
// ),
// Container(
//   margin: const EdgeInsets.symmetric(
//       horizontal: 50, vertical: 16),
//   child: MaterialButton(
//     onPressed: () {
//       setState(() {
//         ref
//             .watch(whatsViewOnMapStateProvider.notifier)
//             .state = '';
//         ref
//             .watch(
//             longitudeListOnMapStateProvider.notifier)
//             .state = [];
//         ref
//             .watch(
//             latitudeListOnMapStateProvider.notifier)
//             .state = [];
//       });
//       ref
//           .watch(whatsViewOnMapStateProvider.notifier)
//           .state = 'Мед. пункт';
//       ref
//           .watch(
//               longitudeListOnMapStateProvider.notifier)
//           .state = [61.4807, 61.4927, 61.4688];
//       ref
//           .watch(
//               latitudeListOnMapStateProvider.notifier)
//           .state = [55.1425, 55.1438, 55.1484];
//     },
//     shape: const CircleBorder(),
//     color: whatsView == 'Мед. пункт'
//         ? Color(0xff0D1F61)
//         : Colors.white,
//     child: Icon(
//       Icons.local_hospital_outlined,
//       color: whatsView == 'Мед. пункт'
//           ? Colors.white
//           : Color(0xff0D1F61),
//     ),
//   ),
// ),
// Container(
//   margin: const EdgeInsets.symmetric(
//       horizontal: 100, vertical: 16),
//   child: MaterialButton(
//     onPressed: () {
//       setState(() {
//         ref
//             .watch(whatsViewOnMapStateProvider.notifier)
//             .state = '';
//         ref
//             .watch(
//             longitudeListOnMapStateProvider.notifier)
//             .state = [];
//         ref
//             .watch(
//             latitudeListOnMapStateProvider.notifier)
//             .state = [];
//       });
//       ref
//           .watch(whatsViewOnMapStateProvider.notifier)
//           .state = 'Тренажерный зал';
//       ref
//           .watch(
//               longitudeListOnMapStateProvider.notifier)
//           .state = [61.45864];
//       ref
//           .watch(
//               latitudeListOnMapStateProvider.notifier)
//           .state = [55.14702];
//     },
//     shape: const CircleBorder(),
//     color: whatsView == 'Тренажерный зал'
//         ? Color(0xff0D1F61)
//         : Colors.white,
//     child: Icon(
//       Icons.fitness_center,
//       color:
//           whatsView == 'Тренажерный зал'
//               ? Colors.white
//               : Color(0xff0D1F61),
//     ),
//   ),
// ),
// Container(
//   margin: const EdgeInsets.symmetric(
//       horizontal: 150, vertical: 16),
//   child: MaterialButton(
//       onPressed: () {
//         setState(() {
//           ref
//               .watch(whatsViewOnMapStateProvider.notifier)
//               .state = '';
//           ref
//               .watch(
//               longitudeListOnMapStateProvider.notifier)
//               .state = [];
//           ref
//               .watch(
//               latitudeListOnMapStateProvider.notifier)
//               .state = [];
//         });
//
//         ref
//             .watch(whatsViewOnMapStateProvider.notifier)
//             .state = 'кпп';
//         ref
//             .watch(longitudeListOnMapStateProvider
//                 .notifier)
//             .state = [61.4749, 61.48474, 61.45938];
//         ref
//             .watch(
//                 latitudeListOnMapStateProvider.notifier)
//             .state = [55.1443, 55.14536, 55.14645];
//       },
//       shape: const CircleBorder(),
//       color: whatsView == 'кпп'
//           ? Color(0xff0D1F61)
//           : Colors.white,
//       child: Text(
//         'кпп',
//         style: TextStyle(
//           color: whatsView == 'кпп'
//               ? Colors.white
//               : Color(0xff0D1F61),
//         ),
//       )),
// ),
