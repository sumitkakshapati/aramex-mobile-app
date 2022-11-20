import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/util/text_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jiffy/jiffy.dart';

class DateUtils {
  static String getTimeDotFomat(String? date) {
    return Jiffy(date).format('dd.MM.yyyy');
  }

  static String getTimeDashFormat(String date) {
    return Jiffy(date, 'dd.MM.yyyy').format('yyyy-MM-dd');
  }

  static String getDateTimeFormat(String? date) {
    return Jiffy(date).format('dd/MM/yyyy') +
        " at " +
        Jiffy(date).format('h:mm a');
  }

  static String getTimeDashFormatFromApi(String? date) {
    return Jiffy(date).format('yyyy-MM-dd');
  }

  static String getTimeSlashFormat(String? date) {
    return Jiffy(date, 'yyyy-MM-dd').format('yyyy/MM/dd');
  }

  static String getFormatedDifference(DateTime? date) {
    if (date != null) {
      return Jiffy(date).fromNow();
    } else {
      return "";
    }
  }

  static String convertToString(DateTime date) {
    return Jiffy(date, 'yMd').format('yyyy-MM-dd');
  }

  static String convertTime(String time) {
    return Jiffy(time, 'H:mm').format('jm');
  }

  static String convertTimeForServer(String time) {
    return Jiffy(time, 'H:mm').format('HH:mm');
  }

  static bool isBefor(String time) {
    return Jiffy().isBefore(time);
  }

  static String getTimeFromSeconds(int seconds) {
    final int hrs = seconds ~/ 3600;
    final int min = (seconds ~/ 60) % 60;
    final int sec = seconds % 60;
    return (hrs > 0 ? hrs.toString() + ":" : "") +
        min.toString().padLeft(2, "0") +
        ":" +
        sec.toString().padLeft(2, "0");
  }

  static DateTime get date {
    final _currentDate = DateTime.now();
    return DateTime(_currentDate.year, _currentDate.month, _currentDate.day);
  }

  static int compareDateDesc(DateTime date, DateTime date2) {
    return date2.compareTo(date);
  }

  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    if (duration.inHours == 0) {
      return "${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
    } else {
      return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
    }
  }
}

extension CustomDuration on Duration {
  Duration parseDuration(String s) {
    s = s.split(".").first;
    int hours = 0;
    int minutes = 0;
    int second = 0;
    final List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.tryParse(parts[parts.length - 3].toString()) ?? 0;
    }
    if (parts.length > 1) {
      minutes = int.tryParse(parts[parts.length - 2].toString()) ?? 0;
    }
    second = int.tryParse(parts[parts.length - 1].toString()) ?? 0;
    return Duration(hours: hours, minutes: minutes, seconds: second);
  }

  String get formatedDuration {
    final String _duration = toString();
    final List<String> parts = _duration.split(':');
    final int hour = int.parse(parts[0]);
    final int min = int.parse(parts[1]);
    final int second = int.parse(parts[2].split(".").first);
    String temp = "";
    if (hour > 0) {
      temp += "$hour ${LocaleKeys.hrs.tr().capitalize()} ";
    }

    if (min > 0) {
      temp += "$min ${LocaleKeys.min.tr().capitalize()} ";
    }

    if (second > 0) {
      temp += "$second ${LocaleKeys.sec.tr().capitalize()}";
    }

    return temp.trim();
  }
}
