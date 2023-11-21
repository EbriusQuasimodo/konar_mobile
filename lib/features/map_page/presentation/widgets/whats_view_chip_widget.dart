import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konar_mobile/features/map_page/presentation/map_controller.dart';

class WhatsViewChipWidget extends ConsumerStatefulWidget {
  final String? itemName;
  final List<String> filters;
  final IconData? icon;

  const WhatsViewChipWidget({
    super.key,
    required this.itemName,
    this.icon,
    required this.filters,
  });

  @override
  ConsumerState<WhatsViewChipWidget> createState() =>
      _WhatsViewChipWidgetState();
}

class _WhatsViewChipWidgetState extends ConsumerState<WhatsViewChipWidget> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(

      side: BorderSide(width: 0, color: widget.filters.contains(widget.itemName)
          ? Color(0xff0D1F61)
          : Colors.white,),
      label:widget.icon != null ? Icon(
        widget.icon,
        size: 35,
        color: widget.filters.contains(widget.itemName)
            ? Colors.white
            : Color(0xff0D1F61),
      ) : Text(widget.itemName!),
      labelStyle: TextStyle(fontSize: 22, color: widget.filters.contains(widget.itemName)
          ? Colors.white
          : Color(0xff0D1F61)),
      selected: widget.filters.contains(widget.itemName),
      selectedColor: Color(0xff0D1F61),
      backgroundColor: Colors.white,
      shape: const CircleBorder(),
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(vertical: 20),
      onSelected: (bool value) {
        setState(() {
          if (value) {
            if (!widget.filters.contains(widget.itemName)) {
              ref.watch(initialZoomOnMapStateProvider.notifier).state = 13.4;
              widget.filters.clear();
              widget.filters.add(widget.itemName!);
              switch (widget.itemName) {
                case 'Столовая':
                  ref.watch(whatsViewOnMapStateProvider.notifier).state =
                      'Столовая';
                  ref.watch(longitudeListOnMapStateProvider.notifier).state = [
                    61.4749,
                    61.48474,
                    61.45938
                  ];
                  ref.watch(latitudeListOnMapStateProvider.notifier).state = [
                    55.1443,
                    55.14536,
                    55.14645
                  ];
                  break;
                case 'Мед. пункт':
                  ref.watch(whatsViewOnMapStateProvider.notifier).state =
                      'Мед. пункт';
                  ref.watch(longitudeListOnMapStateProvider.notifier).state = [
                    61.4807,
                    61.4927,
                    61.4688
                  ];
                  ref.watch(latitudeListOnMapStateProvider.notifier).state = [
                    55.1425,
                    55.1438,
                    55.1484
                  ];
                  break;
                case 'Тренажерный зал':
                  ref.watch(whatsViewOnMapStateProvider.notifier).state =
                      'Тренажерный зал';
                  ref.watch(longitudeListOnMapStateProvider.notifier).state = [
                    61.45864
                  ];
                  ref.watch(latitudeListOnMapStateProvider.notifier).state = [
                    55.14702
                  ];
                  break;
                case 'кпп':
                  ref.watch(whatsViewOnMapStateProvider.notifier).state = 'кпп';
                  ref.watch(longitudeListOnMapStateProvider.notifier).state = [
                    61.45777,
                    61.47101,
                    61.49609
                  ];
                  ref.watch(latitudeListOnMapStateProvider.notifier).state = [
                    55.14751,
                    55.14252,
                    55.14573
                  ];
                  break;
              }
            }
          } else {
            widget.filters.removeWhere((String name) {
              return name == widget.itemName;
            });
            ref.watch(initialZoomOnMapStateProvider.notifier).state = 15;
            ref.watch(whatsViewOnMapStateProvider.notifier).state = '';
            ref.watch(longitudeListOnMapStateProvider.notifier).state = [];
            ref.watch(latitudeListOnMapStateProvider.notifier).state = [];
          }
        });
      },
    );
  }
}
