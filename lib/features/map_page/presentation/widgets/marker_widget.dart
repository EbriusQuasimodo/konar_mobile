import 'package:flutter/material.dart';

class MarkerWidget extends StatelessWidget {
  final int i;
  final int markerId;
  final IconData? icon;
  final String whatsView;
  final VoidCallback onTap;

  const MarkerWidget({
    super.key,
    required this.i,
    required this.markerId,
    required this.icon,
    required this.whatsView,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
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
                    color:
                        markerId == i ? Colors.white : const Color(0xff0D1F61),
                    size: markerId == i ? 30 : 20,
                  )
                : Center(
                    child: Text(
                      whatsView,
                      style: TextStyle(
                          color: markerId == i
                              ? Colors.white
                              : const Color(0xff0D1F61),
                          fontSize: 20,
                          fontWeight: markerId == i
                              ? FontWeight.w600
                              : FontWeight.w500),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
