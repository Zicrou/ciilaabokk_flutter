import 'dart:async';

import 'package:ciilaabokk/app/core/values/app_colors.dart';
import 'package:ciilaabokk/app/core/values/dimens.dart';
import 'package:flutter/material.dart';

final GlobalKey<AppMessageHostState> appMessageHostKey =
    GlobalKey<AppMessageHostState>();

void errorMessage(String textMsg) {
  _showMessage(
    textMsg,
    backgroundColor: AppColors.errorColor,
    icon: Icons.error_outline,
    duration: const Duration(seconds: 3),
  );
}

void goodMessage(String textMsg) {
  _showMessage(
    textMsg,
    backgroundColor: AppColors.primaryColor,
    icon: Icons.notifications_active_outlined,
    duration: const Duration(seconds: 5),
  );
}

void _showMessage(
  String textMsg, {
  required Color backgroundColor,
  required IconData icon,
  required Duration duration,
}) {
  final host = appMessageHostKey.currentState;
  if (host == null) {
    throw StateError('App message host is not available');
  }

  host.showMessage(
    textMsg,
    backgroundColor: backgroundColor,
    icon: icon,
    duration: duration,
  );
}

class AppMessageHost extends StatefulWidget {
  const AppMessageHost({required this.child, super.key});

  final Widget child;

  @override
  State<AppMessageHost> createState() => AppMessageHostState();
}

class AppMessageHostState extends State<AppMessageHost> {
  _AppMessage? _message;
  Timer? _timer;

  void showMessage(
    String text, {
    required Color backgroundColor,
    required IconData icon,
    required Duration duration,
  }) {
    _timer?.cancel();
    setState(() {
      _message = _AppMessage(
        text: text,
        backgroundColor: backgroundColor,
        icon: icon,
      );
    });
    _timer = Timer(duration, () {
      if (mounted) {
        setState(() => _message = null);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final message = _message;
    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        if (message != null)
          Positioned(
            key: const ValueKey('top-app-message'),
            top: MediaQuery.viewPaddingOf(context).top + 12,
            left: 16,
            right: 16,
            child: Material(
              color: message.backgroundColor,
              elevation: 8,
              shadowColor: AppColors.shadowColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      message.icon,
                      color: AppColors.whiteColor,
                      size: Dimens.x4lSize,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Message',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            message.text,
                            style: const TextStyle(color: AppColors.whiteColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _AppMessage {
  const _AppMessage({
    required this.text,
    required this.backgroundColor,
    required this.icon,
  });

  final String text;
  final Color backgroundColor;
  final IconData icon;
}
