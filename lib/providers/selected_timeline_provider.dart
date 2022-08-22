import 'package:flutter/material.dart';

import '../enums/selected_timeline_enum.dart';

class SelectedTimelineProvider with ChangeNotifier {
  SelectedTimelineEnum _selectedTimeline = SelectedTimelineEnum.semua;

  SelectedTimelineEnum get selectedTimeline => _selectedTimeline;

  void setSelectedTimeline(SelectedTimelineEnum timeline) {
    _selectedTimeline = timeline;

    notifyListeners();
  }
}
