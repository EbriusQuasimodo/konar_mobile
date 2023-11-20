import 'package:flutter/material.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(right: 8, left: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset('assets/images/konar_gak.png'),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {},
              ),
            ),
          ),
          const Positioned(
            left: 10,
            top: 10,
            right: 10,
            child: Text(
              'Гости форума «От импортозамещения к технологическому суверенитету» посетили КОНАР',
              maxLines: 3,
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
              '11.11.2023',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
