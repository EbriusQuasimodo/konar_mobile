import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konar_mobile/core/utils/app_router.dart';
import 'package:konar_mobile/features/info_page/presentation/widget/basic_card_widget.dart';
import 'package:konar_mobile/features/info_page/presentation/widget/taxi_card_widget.dart';
import 'package:konar_mobile/features/map_page/presentation/map_controller.dart';

class InfoPage extends ConsumerStatefulWidget {
  const InfoPage({
    super.key,
  });

  @override
  ConsumerState<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends ConsumerState<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Информация'),
        ),
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TaxiCardWidget(),
                    const SizedBox(
                      height: 8,
                    ),
                    BasicCardWidget(
                        onButtonTap: () {
                          ref.watch(initialZoomOnMapStateProvider.notifier).state = 13.4;
                          ref
                              .watch(whatsViewOnMapStateProvider.notifier)
                              .state = 'Столовая';
                          ref
                              .watch(longitudeListOnMapStateProvider.notifier)
                              .state = [61.4749, 61.48474, 61.45938];
                          ref
                              .watch(latitudeListOnMapStateProvider.notifier)
                              .state = [55.1443, 55.14536, 55.14645];

                          ref.read(goRouterProvider).goNamed(
                                AppRoute.mapPage.name,
                              );
                        },
                        cardName: 'Столовые',
                        workTime: '10:00 - 17:00'),
                    const SizedBox(
                      height: 8,
                    ),
                    BasicCardWidget(
                        onButtonTap: () {
                          ref.watch(initialZoomOnMapStateProvider.notifier).state = 13.4;
                          ref
                              .watch(whatsViewOnMapStateProvider.notifier)
                              .state = 'Мед. пункт';
                          ref
                              .watch(longitudeListOnMapStateProvider.notifier)
                              .state = [61.4807, 61.4927, 61.4688];
                          ref
                              .watch(latitudeListOnMapStateProvider.notifier)
                              .state = [55.1425, 55.1438, 55.1484];
                          ref.read(goRouterProvider).goNamed(
                                AppRoute.mapPage.name,
                              );
                        },
                        cardName: 'Мед. пункты',
                        workTime: '8:00 - 19:00'),
                    const SizedBox(
                      height: 8,
                    ),
                    BasicCardWidget(
                        onButtonTap: () {
                          ref.watch(initialZoomOnMapStateProvider.notifier).state = 13.4;
                          ref
                              .watch(whatsViewOnMapStateProvider.notifier)
                              .state = 'Тренажерный зал';
                          ref
                              .watch(longitudeListOnMapStateProvider.notifier)
                              .state = [61.45864];
                          ref
                              .watch(latitudeListOnMapStateProvider.notifier)
                              .state = [55.14702];
                          ref.read(goRouterProvider).goNamed(
                                AppRoute.mapPage.name,
                              );
                        },
                        cardName: 'Тренажерный зал',
                        workTime: '8:00 - 19:00'),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                )),
          ),
        ]));
  }
}
