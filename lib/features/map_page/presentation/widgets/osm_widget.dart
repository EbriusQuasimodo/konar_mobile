import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konar_mobile/features/map_page/presentation/map_controller.dart';
import 'package:konar_mobile/features/map_page/presentation/widgets/marker_widget.dart';
import 'package:konar_mobile/features/map_page/presentation/widgets/whats_view_chip_widget.dart';
import 'package:latlong2/latlong.dart';

class OsmWidget extends ConsumerStatefulWidget {
  final double lat;
  final double long;

  const OsmWidget({super.key, required this.lat, required this.long});

  @override
  ConsumerState<OsmWidget> createState() => _OsmWidgetState();
}

class _OsmWidgetState extends ConsumerState<OsmWidget>
    with TickerProviderStateMixin {
  List<Marker> allMarkers = [];
  int markerId = -1;
  late String whatsView;
  late List<double> lat;
  late List<double> long;
  late double zoom;

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
  static const _useTransformerId = 'useTransformerId';
  bool _useTransformer = true;
  late final _animatedMapController = AnimatedMapController(vsync: this);

  void addCurrentPositionMarker() {
    allMarkers.add(
      Marker(
          width: 40.0,
          height: 40.0,
          point: LatLng(widget.lat, widget.long),
          child: const Icon(
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
            child: MarkerWidget(
                i: i,
                markerId: markerId,
                icon: icon,
                whatsView: whatsView,
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
                            '${whatsView} ${i + 1}',
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
                })),
      );
    }
  }

  void deleteAllMarkers() {
    allMarkers.clear();
  }

  @override
  void dispose() {
    _animatedMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    whatsView = ref.watch(whatsViewOnMapStateProvider);
    lat = ref.watch(latitudeListOnMapStateProvider);
    long = ref.watch(longitudeListOnMapStateProvider);
    zoom = ref.watch(initialZoomOnMapStateProvider);
    ref.listen(initialZoomOnMapStateProvider, (previous, next) {
      if (next > previous!) {
        _animatedMapController.animatedZoomIn(
          customId: _useTransformer ? _useTransformerId : null,
        );
      } else {
        _animatedMapController.animatedZoomOut(
          customId: _useTransformer ? _useTransformerId : null,
        );
      }
    });

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
    return Column(
      children: [
        Flexible(
          child: FlutterMap(
            mapController: _animatedMapController.mapController,
            options: MapOptions(
              initialCenter: LatLng(widget.lat, widget.long),
              initialZoom: zoom,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13, right: 13),
                child: Wrap(
                  children: List.generate(4, (index) {
                    whatsViewSelectedList.clear();
                    whatsViewSelectedList.add(whatsView);
                    return Padding(
                        padding: const EdgeInsets.only(left: 6, right: 6),
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
}
