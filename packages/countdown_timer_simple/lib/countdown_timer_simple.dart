library countdown_timer_simple;

import 'dart:async';

import 'package:flutter/widgets.dart';

/// A Countdown.
class CountdownTimerSimple extends StatefulWidget {
  final int? endTime;
  final String defaultDays;
  final String defaultHours;
  final String defaultMin;
  final String defaultSec;
  final String daysSymbol;
  final String hoursSymbol;
  final String minSymbol;
  final String secSymbol;
  final TextStyle? textStyle;
  final TextStyle? daysTextStyle;
  final TextStyle? hoursTextStyle;
  final TextStyle? minTextStyle;
  final TextStyle? secTextStyle;
  final TextStyle? daysSymbolTextStyle;
  final TextStyle? hoursSymbolTextStyle;
  final TextStyle? minSymbolTextStyle;
  final TextStyle? secSymbolTextStyle;
  final bool showDay;
  final bool showHour;
  final bool showMin;
  final bool showSec;
  final void Function()? onEnd;

  const CountdownTimerSimple({
    super.key,
    this.endTime,
    this.defaultDays = "--",
    this.defaultHours = "--",
    this.defaultMin = "--",
    this.defaultSec = "--",
    this.daysSymbol = "روز",
    this.hoursSymbol = ":",
    this.minSymbol = ":",
    this.secSymbol = "",
    this.textStyle,
    this.daysTextStyle,
    this.hoursTextStyle,
    this.minTextStyle,
    this.secTextStyle,
    this.daysSymbolTextStyle,
    this.hoursSymbolTextStyle,
    this.minSymbolTextStyle,
    this.secSymbolTextStyle,
    this.showDay = true,
    this.showHour = true,
    this.showMin = true,
    this.showSec = true,
    this.onEnd,
  });

  @override
  State<CountdownTimerSimple> createState() => _CountDownState();
}

class _CountDownState extends State<CountdownTimerSimple> {
  DiffDate? diffDate;
  Timer? _diffTimer;
  final defaultTextStyle = const TextStyle(fontSize: 20);

  DiffDate? getDateData() {
    if (widget.endTime == null) return null;
    int diff =
        ((widget.endTime! - DateTime.now().millisecondsSinceEpoch) / 1000)
            .floor();
    if (diff < 0) {
      return null;
    }
    int days, hours, min, sec;
    if (diff >= 86400) {
      days = (diff / 86400).floor();
      diff -= days * 86400;
    } else {
      days = -1;
    }
    if (diff >= 3600) {
      hours = (diff / 3600).floor();
      diff -= hours * 3600;
    } else {
      hours = 0;
    }
    if (diff >= 60) {
      min = (diff / 60).floor();
      diff -= min * 60;
    } else {
      min = 0;
    }
    sec = diff.toInt();
    return DiffDate(days: days, hours: hours, min: min, sec: sec);
  }

  @override
  void initState() {
    timerDiffDate();
    super.initState();
  }

  void timerDiffDate() {
    DiffDate? data = getDateData();
    if (data != null) {
      setState(() {
        diffDate = data;
      });
    } else {
      return;
    }
    disposeDiffTimer();
    const period = Duration(seconds: 1);
    _diffTimer = Timer.periodic(period, (timer) {
      DiffDate? data = getDateData();
      if (data != null) {
        setState(() {
          diffDate = data;
        });
        checkDateEnd(data);
      } else {
        disposeDiffTimer();
      }
    });
  }

  @override
  void dispose() {
    disposeDiffTimer();
    super.dispose();
  }

  void disposeDiffTimer() {
    _diffTimer?.cancel();
    _diffTimer = null;
  }

  @override
  void didUpdateWidget(CountdownTimerSimple oldWidget) {
    if (oldWidget.endTime != widget.endTime) {
      timerDiffDate();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: _items(),
    );
  }

  TextStyle _getTextStyle(TextStyle? textStyle) {
    return textStyle ?? widget.textStyle ?? defaultTextStyle;
  }

  List<Widget> _items() {
    final list = <Widget>[];
    final current = diffDate;
    if (current == null) {
      return list;
    }

    if (widget.showDay) {
      if (current.days != -1) {
        var days = _getNumberAddZero(current.days);
        list.add(Text(
          days ?? widget.defaultDays,
          style: _getTextStyle(widget.daysTextStyle),
        ));
        list.add(Text(
          widget.daysSymbol,
          style: _getTextStyle(widget.daysSymbolTextStyle),
        ));
      }
    }

    if (widget.showHour) {
      if (current.hours != -1) {
        var hours = _getNumberAddZero(current.hours);
        list.add(Text(
          hours ?? widget.defaultHours,
          style: _getTextStyle(widget.hoursTextStyle),
        ));
        list.add(Text(
          widget.hoursSymbol,
          style: _getTextStyle(widget.hoursSymbolTextStyle),
        ));
      }
    }

    if (widget.showMin) {
      if (current.min != -1) {
        var min = _getNumberAddZero(current.min);
        list.add(Text(
          min ?? widget.defaultMin,
          style: _getTextStyle(widget.minTextStyle),
        ));
        list.add(Text(
          widget.minSymbol,
          style: _getTextStyle(widget.minSymbolTextStyle),
        ));
      }
    }

    if (widget.showSec) {
      if (current.sec != -1) {
        var sec = _getNumberAddZero(current.sec);
        list.add(Text(
          sec ?? widget.defaultSec,
          style: _getTextStyle(widget.secTextStyle),
        ));
        list.add(Text(
          widget.secSymbol,
          style: _getTextStyle(widget.secSymbolTextStyle),
        ));
      }
    }

    return list;
  }

  String? _getNumberAddZero(int? number) {
    if (number == null) {
      return null;
    }
    if (number < 10) {
      return "0$number";
    }
    return number.toString();
  }

  void checkDateEnd(DiffDate data) {
    if (data.days == -1 && data.hours == 0 && data.min == 0 && data.sec == 0) {
      widget.onEnd?.call();
      disposeDiffTimer();
    }
  }
}

class DiffDate {
  final int days;
  final int hours;
  final int min;
  final int sec;

  DiffDate({
    required this.days,
    required this.hours,
    required this.min,
    required this.sec,
  });
}
