import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konar_mobile/features/login_page/data/login_repository.dart';
import 'package:konar_mobile/features/main_page/presentation/widgets/news_card_widget.dart';
import 'package:expandable_page_view/expandable_page_view.dart';

class MainPageBodyUserWidget extends ConsumerStatefulWidget {
  const MainPageBodyUserWidget({super.key});

  @override
  MainPageBodyUserWidgetState createState() => MainPageBodyUserWidgetState();
}

class MainPageBodyUserWidgetState
    extends ConsumerState<MainPageBodyUserWidget> {
  final _controllerNews = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
  }

  @override
  void dispose() {
    _controllerNews.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(realAuthRepositoryProvider).currentUser;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'КОНАР Новости',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                      onPressed: () {}, child: const Text('посмотреть все')),
                )
              ],
            ),
            ExpandablePageView(controller: _controllerNews, children: const [
              NewsCardWidget(),
              NewsCardWidget(),
              NewsCardWidget(),
              NewsCardWidget(),
              NewsCardWidget(),
            ]),
            SizedBox(height: 5,),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: MaterialButton(
                minWidth: double.infinity,
                color: Colors.white70,
                elevation: 0,
                height: 60,
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(Icons.calendar_month, color: Color(0xff0D1F61),),
                    SizedBox(width: 6,),
                    Text(
                      'Календарь мероприятий КОНАР',
                      style: TextStyle(
                          color: Color(0xff0D1F61),
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: MaterialButton(
                minWidth: double.infinity,
                color: Colors.white70,
                elevation: 0,
                height: 60,
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(Icons.celebration, color: Color(0xff0D1F61),),
                    SizedBox(width: 6,),
                    Text(
                      'Афиша мероприятий КОНАР',
                      style: TextStyle(
                          color: Color(0xff0D1F61),
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
