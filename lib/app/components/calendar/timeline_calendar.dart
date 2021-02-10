import 'package:date_picker_timeline/gestures/tap.dart';
import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TimelineCalendar extends StatefulWidget {
  const TimelineCalendar(
    this.startDate, {
    this.width = kTimeLineDayWidth,
    this.height = kTimeLineDayHeight,
    this.controller,
    this.dayTextStyle,
    this.dateTextStyle,
    this.selectedBorderColor,
    this.initialSelectedDate,
    this.activeDates,
    this.inactiveDates,
    this.daysCount = 30,
    this.onDateChange,
    this.locale = 'en_US',
    this.selectedDayTextStyle,
    this.deactivatedDayTextStyle,
    this.selectedDateTextStyle,
    this.deactivatedDateStyle,
    this.selectedBackgroundColor,
    this.borderColor,
    this.backgroundColor,
    this.todayTitle = 'Today',
  }) : assert(
          activeDates == null || inactiveDates == null,
          "Can't "
          'provide both activated and deactivated dates List at the same time.',
        );

  /// Start Date in case user wants to show past dates
  /// If not provided calendar will start from the initialSelectedDate
  final DateTime startDate;

  /// Width of the selector
  final double width;

  /// Height of the selector
  final double height;

  /// DatePicker Controller
  final DatePickerController controller;

  /// Text color for the selected Date
  final TextStyle deactivatedDayTextStyle;

  /// Text color border for the selector Date
  final Color selectedBorderColor;

  /// Text color border for the selector Date
  final Color borderColor;

  /// Text color border for the selector Date
  final Color backgroundColor;

  final Color selectedBackgroundColor;

  // Text Color for the deactivated dates
  final TextStyle selectedDateTextStyle;

  // Text Color for the deactivated dates
  final TextStyle deactivatedDateStyle;

  /// TextStyle for day Value
  final TextStyle dayTextStyle;

  /// TextStyle for day Value
  final TextStyle selectedDayTextStyle;

  /// TextStyle for the date Value
  final TextStyle dateTextStyle;

  /// Current Selected Date
  final DateTime initialSelectedDate;

  /// Contains the list of inactive dates.
  /// All the dates defined in this List will be deactivated
  final List<DateTime> inactiveDates;

  /// Contains the list of active dates.
  /// Only the dates in this list will be activated.
  final List<DateTime> activeDates;

  /// Callback function for when a different date is selected
  final DateChangeListener onDateChange;

  /// Max limit up to which the dates are shown.
  /// Days are counted from the startDate
  final int daysCount;

  /// Locale for the calendar default: en_us
  final String locale;

  final String todayTitle;

  @override
  State<StatefulWidget> createState() => _TimelineCalendarState();
}

class _TimelineCalendarState extends State<TimelineCalendar> {
  DateTime _currentDate;

  final ScrollController _scrollController = ScrollController();

  TextStyle deactivatedDateStyle;
  TextStyle deactivatedMonthStyle;
  TextStyle deactivatedDayStyle;
  @override
  void initState() {
    // Init the calendar locale
    initializeDateFormatting(widget.locale, null);

    if (widget.controller != null) {
      widget.controller.setDatePickerState(this);
    }

    super.initState();
  }

  /// This will return a text style for the Selected date Text Values
  /// the only change will be the color provided
  TextStyle createTextStyle(TextStyle style, Color color) {
    if (color != null) {
      return TextStyle(
        color: color,
        fontSize: style.fontSize,
        fontWeight: style.fontWeight,
        fontFamily: style.fontFamily,
        letterSpacing: style.letterSpacing,
      );
    } else {
      return style;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set initial Values
    _currentDate = widget.initialSelectedDate;
    final TextStyle dayTextStyle =
        widget.dayTextStyle ?? AppTextStyle(color: kAppGreyB).primaryLabel4;

    final TextStyle selectedDayTextStyle = widget.selectedDayTextStyle ??
        AppTextStyle(color: kAppWhite).primaryLabel4;

    final TextStyle deactivatedDayStyle = widget.deactivatedDayTextStyle ??
        AppTextStyle(color: kAppGreyB).primaryLabel4;

    final TextStyle dateTextStyle =
        widget.dateTextStyle ?? AppTextStyle(color: kAppBlack).primaryLabel4;

    final TextStyle selectedDateTextStyle = widget.selectedDateTextStyle ??
        AppTextStyle(color: kAppWhite).primaryLabel4;

    final TextStyle deactivatedDateStyle = widget.deactivatedDateStyle ??
        AppTextStyle(color: kAppGreyB).primaryLabel4;

    final Color borderColor = widget.borderColor ?? kAppGreyD;

    final Color backgroundColor = widget.backgroundColor ?? Colors.transparent;

    final Color selectedBorderColor =
        widget.selectedBorderColor ?? kAppPrimaryElectricBlue;

    final Color selectedBackgroundColor =
        widget.selectedBackgroundColor ?? kAppPrimaryElectricBlue;

    int _daysCount = widget.daysCount;

    for (int index = 0; index < widget.daysCount; index++) {
      DateTime date;
      final DateTime _date = widget.startDate.add(Duration(days: index));
      date = DateTime(_date.year, _date.month, _date.day);

      bool isDeactivated = false;

      if (widget.inactiveDates != null) {
        for (final DateTime inactiveDate in widget.inactiveDates) {
          if (_compareDate(date, inactiveDate)) {
            isDeactivated = true;
            break;
          }
        }
      }
      if (isDeactivated) {
        _daysCount++;
      }
    }

    return Container(
      height: widget.height,
      child: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(-kSpacer.xxs, kSpacer.none),
            child: ListView.builder(
              padding: kSpacer.edgeInsets.x.standard,
              itemCount: _daysCount,
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                // get the date object based on the index position
                // if widget.startDate is null then use the initialDateValue
                DateTime date;
                final DateTime _date =
                    widget.startDate.add(Duration(days: index));
                date = DateTime(_date.year, _date.month, _date.day);

                bool isDeactivated = false;

                // check if this date needs to be deactivated for only DeactivatedDates
                if (widget.inactiveDates != null) {
                  for (final DateTime inactiveDate in widget.inactiveDates) {
                    if (_compareDate(date, inactiveDate)) {
                      isDeactivated = true;
                      break;
                    }
                  }
                }

                // check if this date needs to be deactivated for only ActivatedDates
                if (widget.activeDates != null) {
                  isDeactivated = true;
                  for (final DateTime activateDate in widget.activeDates) {
                    // Compare the date if it is in the
                    if (_compareDate(date, activateDate)) {
                      isDeactivated = false;
                      break;
                    }
                  }
                }

                // Check if this date is the one that is currently selected
                final bool isSelected =
                    _currentDate != null && _compareDate(date, _currentDate);

                if (isDeactivated) {
                  return Container();
                }

                // Return the Date Widget
                return DateWidget(
                  date: date,
                  todayTitle: widget.todayTitle,
                  dateTextStyle: isDeactivated
                      ? deactivatedDateStyle
                      : isSelected
                          ? selectedDateTextStyle
                          : dateTextStyle,
                  dayTextStyle: isDeactivated
                      ? deactivatedDayStyle
                      : isSelected
                          ? selectedDayTextStyle
                          : dayTextStyle,
                  width: widget.width,
                  locale: widget.locale,
                  selectedBackgroundColor:
                      isSelected ? selectedBackgroundColor : backgroundColor,
                  selectedBorderColor:
                      isSelected ? selectedBorderColor : borderColor,
                  onDateSelected: (DateTime selectedDate) {
                    // Don't notify listener if date is deactivated
                    if (isDeactivated) {
                      return;
                    }

                    // A date is selected
                    if (widget.onDateChange != null) {
                      widget.onDateChange(selectedDate);
                    }
                    setState(() {
                      _currentDate = selectedDate;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Helper function to compare two dates
  /// Returns True if both dates are the same
  bool _compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }
}

class DatePickerController {
  _TimelineCalendarState _datePickerState;

  void setDatePickerState(_TimelineCalendarState state) {
    _datePickerState = state;
  }

  void jumpToSelection() {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    // jump to the current Date
    _datePickerState._scrollController
        .jumpTo(_calculateDateOffset(_datePickerState._currentDate));
  }

  /// This function will animate the Timeline to the currently selected Date
  void animateToSelection({
    Duration duration = kDuration300,
    Curve curve = Curves.linear,
  }) {
    assert(
      _datePickerState != null,
      'DatePickerController is not attached to any DatePicker View.',
    );

    // animate to the current date
    _datePickerState._scrollController.animateTo(
      _calculateDateOffset(_datePickerState._currentDate),
      duration: duration,
      curve: curve,
    );
  }

  /// This function will animate to any date that is passed as a parameter
  /// In case a date is out of range nothing will happen
  void animateToDate(
    DateTime date, {
    Duration duration = kDuration300,
    Curve curve = Curves.linear,
  }) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState._scrollController.animateTo(
      _calculateDateOffset(date),
      duration: duration,
      curve: curve,
    );
  }

  /// Calculate the number of pixels that needs to be scrolled to go to the
  /// date provided in the argument
  double _calculateDateOffset(DateTime date) {
    final DateTime startDate = DateTime(
      _datePickerState.widget.startDate.year,
      _datePickerState.widget.startDate.month,
      _datePickerState.widget.startDate.day,
    );

    final int offset = date.difference(startDate).inDays;
    return offset * _datePickerState.widget.width;
  }
}

class DateWidget extends StatelessWidget {
  const DateWidget({
    @required this.date,
    @required this.dayTextStyle,
    @required this.dateTextStyle,
    @required this.selectedBackgroundColor,
    @required this.selectedBorderColor,
    this.width,
    this.onDateSelected,
    this.locale,
    this.todayTitle,
  });

  final double width;
  final DateTime date;
  final TextStyle dayTextStyle, dateTextStyle;
  final Color selectedBackgroundColor;
  final Color selectedBorderColor;
  final DateSelectionCallback onDateSelected;
  final String locale;
  final String todayTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: width,
        margin: AppSpacer(context: context).edgeInsets.all.xxs,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(kBorderRadiusSmall),
          ),
          border: Border.all(
            color: selectedBorderColor,
            width: kBorderDayWidth,
          ),
          color: selectedBackgroundColor,
        ),
        child: Padding(
          padding: kSpacer.edgeInsets.all.xxs,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                date.day.toString(), // Date
                style: dateTextStyle,
              ),
              const SizedBox(
                height: 2.0,
              ),
              if (_calculateDifference(date) == 0) ...<Widget>[
                Text(
                  todayTitle,
                  style: dayTextStyle,
                )
              ] else ...<Widget>[
                Text(
                  DateFormat('MMM').format(date), // Short month
                  style: dayTextStyle,
                )
              ]
            ],
          ),
        ),
      ),
      onTap: () {
        if (onDateSelected != null) {
          onDateSelected(date);
        }
      },
    );
  }

  int _calculateDifference(DateTime date) {
    final DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}
