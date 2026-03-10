import 'dart:convert';

void main() {
  final now = DateTime.now();
  final quitDate = now.subtract(const Duration(days: 5));
  
  // They smoked YESTERDAY. Streak should be 1.
  final yesterday = now.subtract(const Duration(days: 1));
  final dateKey = "${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}";
  
  Map<String, dynamic> slipHistory = {
    dateKey: 1,
  };
  
  // Run Streak logic on state BEFORE fast forward
  int getStreak(DateTime start, Map<String, dynamic> history) {
    DateTime? latestSlipUtc;
    final sortedKeys = history.keys.toList()..sort();
    for (final key in sortedKeys.reversed) {
      if ((history[key] as num?)?.toInt() != 0) {
        final parts = key.split('-');
        if (parts.length == 3) {
          latestSlipUtc = DateTime.utc(
            int.parse(parts[0]),
            int.parse(parts[1]),
            int.parse(parts[2]),
          );
        }
        break;
      }
    }

    final todayUtc = DateTime.utc(now.year, now.month, now.day);
    final quitDayUtc = DateTime.utc(start.year, start.month, start.day);
    
    int daysSinceQuit = todayUtc.difference(quitDayUtc).inDays;
    if (daysSinceQuit < 0) daysSinceQuit = 0;

    if (latestSlipUtc != null) {
      int daysSinceSlip = todayUtc.difference(latestSlipUtc).inDays;
      if (daysSinceSlip < 0) daysSinceSlip = 0;
      return daysSinceSlip > daysSinceQuit ? daysSinceQuit : daysSinceSlip;
    }
    return daysSinceQuit;
  }
  
  print('Streak BEFORE FF: ${getStreak(quitDate, slipHistory)}');
  print('slipHistory BEFORE FF: $slipHistory');
  
  // Run debugFastForward logic
  final newQuitDate = quitDate.subtract(const Duration(days: 7));
  final newSlipHistory = <String, dynamic>{};
  slipHistory.forEach((key, value) {
    final parts = key.split('-');
    if (parts.length == 3) {
      final d = DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
      final shifted = d.subtract(const Duration(days: 7));
      final shiftedKey = "${shifted.year}-${shifted.month.toString().padLeft(2, '0')}-${shifted.day.toString().padLeft(2, '0')}";
      newSlipHistory[shiftedKey] = value;
    }
  });
  
  print('slipHistory AFTER FF: $newSlipHistory');
  print('Streak AFTER FF: ${getStreak(newQuitDate, newSlipHistory)}');
}
