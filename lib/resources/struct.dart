import 'package:flutter/material.dart';

import 'colors_custom.dart';

List<Map<String, dynamic>> menu = [
  {
    'name': 'Database',
    'icon': Icons.abc,
    'screens': [
      {
        'name': 'CRUD operations',
        'icon': const Icon(
          Icons.task_alt,
          color: Palette.pfsNavy,
        ),
        'widget': null,
      },
      {
        'name': 'Storage',
        'icon': const Icon(
          Icons.storage_rounded,
          color: Palette.pfsNavy,
        ),
        'widget': null,
      },
    ]
  },
  {
    'name': 'Backend Actions',
    'icon': Icons.abc,
    'screens': [
      {
        'name': 'Cloud Functions',
        'icon': const Icon(
          Icons.image,
          color: Palette.pfsNavy,
        ),
        'widget': null,
      },
      {
        'name': 'Push Notifications (FCM)',
        'icon': const Icon(
          Icons.image,
          color: Palette.pfsNavy,
        ),
        'widget': null,
      },
    ]
  }
];
