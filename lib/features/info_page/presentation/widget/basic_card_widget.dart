import 'package:flutter/material.dart';

class BasicCardWidget extends StatelessWidget {
  final VoidCallback onButtonTap;
  final String cardName;
  final String workTime;
  const BasicCardWidget({super.key, required this.onButtonTap, required this.cardName, required this.workTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cardName,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Часы работы: ',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Text(
                workTime,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black45),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 4, bottom: 4),
            color: Colors.black45,
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                //'lat': '[55.14702]',
                //  'long': '[61.45864]',
                // 'whatsView': 'Тренажерный зал'
                onTap: () {
                  onButtonTap();

                },
                child: Text(
                  'Показать на карте',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.black45,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
