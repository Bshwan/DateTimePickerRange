import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/src/time_picker_spinner.dart';

/// Omni DateTimeRange Picker
///
/// If properties are not given, default value will be used.
class OmniDateTimeRangePicker extends StatefulWidget {
  /// Start initial datetime
  ///
  /// Default value: DateTime.now()
  final DateTime? startInitialDate;

  /// Minimum date that can be selected
  ///
  /// Default value: DateTime.now().subtract(const Duration(days: 3652))
  final DateTime? startFirstDate;

  /// Maximum date that can be selected
  ///
  /// Default value: DateTime.now().add(const Duration(days: 3652))
  final DateTime? startLastDate;

  /// End initial datetime
  ///
  /// Default value: DateTime.now().add(const Duration(days: 1))
  final DateTime? endInitialDate;

  /// Minimum date that can be selected
  ///
  /// Default value: DateTime.now().subtract(const Duration(days: 3652))
  final DateTime? endFirstDate;

  /// Maximum date that can be selected
  ///
  /// Default value: DateTime.now().add(const Duration(days: 3652))
  final DateTime? endLastDate;

  final bool? is24HourMode;
  final bool? isShowSeconds;

  final Color? primaryColor;
  final Color? backgroundColor;
  final Color? calendarTextColor;
  final Color? tabTextColor;
  final Color? unselectedTabBackgroundColor;
  final Color? buttonTextColor;
  final TextStyle? timeSpinnerTextStyle;
  final TextStyle? timeSpinnerHighlightedTextStyle;
  final Radius? borderRadius;
  final String? startDateLabel;
  final String? endDateLabel;
  final String? cancelButtonText;
  final String? saveButtonText;

  const OmniDateTimeRangePicker(
      {Key? key,
      this.startInitialDate,
      this.startFirstDate,
      this.startLastDate,
      this.endInitialDate,
      this.endFirstDate,
      this.endLastDate,
      this.is24HourMode,
      this.isShowSeconds,
      this.primaryColor,
      this.backgroundColor,
      this.calendarTextColor,
      this.tabTextColor,
      this.unselectedTabBackgroundColor,
      this.buttonTextColor,
      this.timeSpinnerTextStyle,
      this.timeSpinnerHighlightedTextStyle,
      this.borderRadius,
      this.cancelButtonText,
      this.endDateLabel,
      this.saveButtonText,
      this.startDateLabel})
      : super(key: key);

  @override
  State<OmniDateTimeRangePicker> createState() =>
      _OmniDateTimeRangePickerState();
}

class _OmniDateTimeRangePickerState extends State<OmniDateTimeRangePicker>
    with SingleTickerProviderStateMixin {
  /// startDateTime will be returned in a List<DateTime> with index 0
  ///
  /// Initial value: Current DateTime
  DateTime startDateTime = DateTime.now();

  /// endDateTime will be returned in a List<DateTime> with index 1
  ///
  /// Initial value: 1 day after current DateTime
  DateTime endDateTime = DateTime.now().add(const Duration(days: 1));

  PageController _pageController = PageController();
  int currentPage = 0;
  @override
  void initState() {
    if (widget.startInitialDate != null) {
      startDateTime = widget.startInitialDate!;
    }

    if (widget.endInitialDate != null) {
      endDateTime = widget.endInitialDate!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      child: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: widget.primaryColor ?? Colors.blue,
                surface: widget.backgroundColor ?? Colors.white,
                onSurface: widget.calendarTextColor ?? Colors.black,
              ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(0,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeInOut);
                        setState(() {
                          currentPage = 0;
                        });
                      },
                      child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: currentPage == 0
                                  ? widget.backgroundColor ?? Colors.white
                                  : widget.unselectedTabBackgroundColor ??
                                      Colors.grey[200],
                              borderRadius: BorderRadius.only(
                                topLeft: widget.borderRadius ??
                                    const Radius.circular(16),
                                topRight: widget.borderRadius ??
                                    const Radius.circular(16),
                              )),
                          child: Text(
                            widget.startDateLabel ?? "Start Date",
                            style: TextStyle(
                                color: widget.tabTextColor ?? Colors.black87),
                          )),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(1,
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeInOut);

                        setState(() {
                          currentPage = 1;
                        });
                      },
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: currentPage == 1
                                ? widget.backgroundColor ?? Colors.white
                                : widget.unselectedTabBackgroundColor ??
                                    Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topLeft: widget.borderRadius ??
                                  const Radius.circular(16),
                              topRight: widget.borderRadius ??
                                  const Radius.circular(16),
                            )),
                        child: Text(
                          widget.endDateLabel ?? "End Date",
                          style: TextStyle(
                              color: widget.tabTextColor ?? Colors.black87),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height - 180),
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? Colors.white,
                ),
                child: PageView(
                  controller: _pageController,
                  physics: ClampingScrollPhysics(),
                  children: [
                    /// Start date
                    StartDatePicker(
                        startDateTime: startDateTime,
                        calendarTextColor: widget.calendarTextColor,
                        startFirstDate: widget.startFirstDate,
                        startLastDate: widget.startLastDate,
                        timeSpinnerTextStyle: widget.timeSpinnerTextStyle,
                        timeSpinnerHighlightedTextStyle:
                            widget.timeSpinnerHighlightedTextStyle,
                        startInitialDate: DateTime.now(),
                        onDateChange: (date) {
                          startDateTime = date;
                        }),
                    StartDatePicker(
                        startDateTime: startDateTime,
                        calendarTextColor: widget.calendarTextColor,
                        startFirstDate: widget.startFirstDate,
                        startLastDate: widget.startLastDate,
                        timeSpinnerTextStyle: widget.timeSpinnerTextStyle,
                        timeSpinnerHighlightedTextStyle:
                            widget.timeSpinnerHighlightedTextStyle,
                        startInitialDate: DateTime.now(),
                        onDateChange: (date) {
                          endDateTime = date;
                        }),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: widget.backgroundColor ?? Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft:
                        widget.borderRadius ?? const Radius.circular(16),
                    bottomRight:
                        widget.borderRadius ?? const Radius.circular(16),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft:
                        widget.borderRadius ?? const Radius.circular(16),
                    bottomRight:
                        widget.borderRadius ?? const Radius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: CupertinoButton(
                          pressedOpacity: 0.6,
                          onPressed: () {
                            Navigator.of(context).pop<List<DateTime>>();
                          },
                          child: Text(
                            widget.cancelButtonText ?? "Cancel",
                            style: TextStyle(
                                color: widget.buttonTextColor ?? Colors.black,
                                fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                        child: VerticalDivider(
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: CupertinoButton(
                          pressedOpacity: 0.6,
                          onPressed: () {
                            Navigator.pop<List<DateTime>>(context, [
                              startDateTime,
                              endDateTime,
                            ]);
                          },
                          child: Text(
                            widget.saveButtonText ?? "Confirm",
                            style: TextStyle(
                                color: widget.buttonTextColor ?? Colors.black,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StartDatePicker extends StatefulWidget {
  final DateTime startDateTime;
  final DateTime startInitialDate;
  final DateTime? startLastDate;
  final TextStyle? timeSpinnerTextStyle;
  final DateTime? startFirstDate;
  final Color? calendarTextColor;
  final TextStyle? timeSpinnerHighlightedTextStyle;
  final Function(DateTime) onDateChange;
  StartDatePicker(
      {Key? key,
      required this.startDateTime,
      required this.startInitialDate,
      this.timeSpinnerTextStyle,
      this.startFirstDate,
      this.calendarTextColor,
      this.timeSpinnerHighlightedTextStyle,
      this.startLastDate,
      required this.onDateChange})
      : super(key: key);

  @override
  State<StartDatePicker> createState() => _StartDatePickerState();
}

class _StartDatePickerState extends State<StartDatePicker>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CalendarDatePicker(
            initialDate: widget.startInitialDate,
            firstDate: widget.startFirstDate ??
                DateTime.now().subtract(const Duration(days: 3652)),
            lastDate: widget.startLastDate ??
                DateTime.now().add(const Duration(days: 3652)),
            onDateChanged: (dateTime) {
              print('date changed' + dateTime.toString());

              DateTime date = DateTime(
                dateTime.year,
                dateTime.month,
                dateTime.day,
                widget.startDateTime.hour,
                widget.startDateTime.minute,
              );
              widget.onDateChange(date);
            },
          ),
          TimePickerSpinner(
            is24HourMode: false,
            isShowSeconds: false,
            normalTextStyle: widget.timeSpinnerTextStyle ??
                TextStyle(
                    fontSize: 18,
                    color: widget.calendarTextColor ?? Colors.black54),
            highlightedTextStyle: widget.timeSpinnerHighlightedTextStyle ??
                TextStyle(
                    fontSize: 24,
                    color: widget.calendarTextColor ?? Colors.black),
            time: widget.startDateTime,
            onTimeChange: (dateTime) {
              print('date changed' + dateTime.toString());
              DateTime tempStartDateTime = DateTime(
                widget.startDateTime.year,
                widget.startDateTime.month,
                widget.startDateTime.day,
                dateTime.hour,
                dateTime.minute,
                dateTime.second,
              );
              widget.onDateChange(tempStartDateTime);

              // widget.startDateTime = tempStartDateTime;
            },
          ),
        ],
      ),
    );
  }
}
