import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TaxiCardWidget extends StatelessWidget {
  const TaxiCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Такси',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w500),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Часы работы: ',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Text(
                '8:00 - 17:00',
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
          const Text(
            'Номера телефонов: ',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w400),
          ),
          Row(
            children: [
              const Text(
                'Пежо: ',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w400),
              ),
              InkWell(
                onTap: () async {
                  const url = "tel:+7 982 330-46-67";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: const Text(
                  '+7 982 330-46-67',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black45),
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text(
                'Хендай: ',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w400),
              ),
              InkWell(
                onTap: () async {
                  const url = "tel:+7 982 330-47-02";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: const Text(
                  '+7 982 330-47-02',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black45),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
