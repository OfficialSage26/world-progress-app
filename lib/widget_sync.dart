import 'package:home_widget/home_widget.dart';

class WidgetSync {
  static const percentKey = 'percent_line';
  static const dateKey = 'date_line';
  static const progressBpKey = 'progress_bp'; // 0..10000

  static Future<void> save({
    required String percentLine,
    required String dateLine,
    required int progressBp,
  }) async {
    await HomeWidget.saveWidgetData<String>(percentKey, percentLine);
    await HomeWidget.saveWidgetData<String>(dateKey, dateLine);
    await HomeWidget.saveWidgetData<int>(progressBpKey, progressBp);
  }
}
