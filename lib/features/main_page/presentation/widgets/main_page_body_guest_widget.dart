import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konar_mobile/core/presentation/auth_button_widget.dart';
import 'package:konar_mobile/features/login_page/data/login_repository.dart';
import 'package:konar_mobile/features/main_page/presentation/widgets/news_card_widget.dart';

class MainPageBodyGuestWidget extends ConsumerStatefulWidget {
  const MainPageBodyGuestWidget({super.key});


  @override
  MainPageBodyGuestWidgetState createState() => MainPageBodyGuestWidgetState();
}

class MainPageBodyGuestWidgetState
    extends ConsumerState<MainPageBodyGuestWidget> {
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
    return CustomScrollView(
      slivers: [SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset('assets/images/konar_gak.png'),
                    ),
                    const Positioned(
                      left: 10,
                      bottom: 30,
                      child: Text(
                        'КОНАР',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                    const Positioned(
                      left: 10,
                      bottom: 10,
                      child: Text(
                        'Мобильное приложение для сотрудников',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: AuthButtonWidget(),
              ),
              const SizedBox(height: 5,),
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
                        'Вакансии',
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
                        'Записаться на экскурсию',
                        style: TextStyle(
                            color: Color(0xff0D1F61),
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: ExpandablePageView(controller: _controllerNews, children: const [
                  NewsCardWidget(),
                  NewsCardWidget(),
                  NewsCardWidget(),
                  NewsCardWidget(),
                  NewsCardWidget(),
                ]),
              ),


            ],
          ),
        ),
      ),]
    );
  }
}
