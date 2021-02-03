import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/wide_button.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:jiffy/jiffy.dart';

extension CalendarDialog on Dialog {
  // Use: CalendarDialog.show(...)
  static Future<void> show({
    @required BuildContext context,
    DateTime selectedDay,
    DateTime startDay,
    DateTime endDay,
    DateTime initialDate,
    List<DateTime> listDateDisabled,
    double borderCalendar = kBorderRadiusSmall,
    EdgeInsets paddingDay,
    bool barrierDismissible = true,
    int numberMonthToShow = 12,
    List<String> customWeekDays,
    Color borderDayColor = kAppGreyD,
    Color borderCurrentDayColor = kAppSecondaryPink,
    Color backgroundSelectedDay = kAppPrimaryElectricBlue,
    Color backgroundDisabledDay = kAppGreyD,
    TextStyle dayTextStyle,
    TextStyle selectedDayTextStyle,
    TextStyle currentDayTextStyle,
    TextStyle disabledDayTextStyle,
    Widget builderActions,
    Function(DateTime) onPressDay,
    MaterialRoundedDatePickerStyle materialRoundedDatePickerStyle,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)
        transitionBuilder,
  }) {
    // get first day of month
    final DateTime firstDate = DateTime(
      startDay?.year ?? Jiffy().year,
      startDay?.month ?? Jiffy().month,
    );

    // get first day of month
    DateTime lastDate = DateTime(
      endDay?.year ?? Jiffy().add(months: numberMonthToShow).year,
      endDay?.month ?? Jiffy().add(months: numberMonthToShow).month,
    );

    // add days in month to selectable all day of month
    lastDate = lastDate.add(Duration(days: _daysInMonth(lastDate) - 1));

    paddingDay = paddingDay ??
        EdgeInsets.symmetric(horizontal: kSpacer.xxs, vertical: 2.0);

    initialDate ??= DateTime.now();
    selectedDay ??= DateTime.now();

    final MaterialRoundedDatePickerStyle datePickerStyle =
        materialRoundedDatePickerStyle ??
            MaterialRoundedDatePickerStyle(
              sizeArrow: kSmallIconSize,
              colorArrowNext: kAppPrimaryElectricBlue,
              colorArrowPrevious: kAppPrimaryElectricBlue,
              marginTopArrowNext: kSpacer.sm,
              marginTopArrowPrevious: kSpacer.sm,
              textStyleDayOnCalendarSelected: selectedDayTextStyle,
              textStyleDayHeader: AppTextStyle(color: kAppGreyB).primaryLabel3,
              textStyleMonthYearHeader:
                  AppTextStyle(color: kAppGreyA).primaryH4,
              paddingMonthHeader: EdgeInsets.only(
                top: kSpacer.sm,
                bottom: kSpacer.standard,
              ),
              paddingDatePicker: EdgeInsets.only(
                left: kSpacer.sm,
                right: kSpacer.sm,
                top: kSpacer.sm,
              ),
            );

    Widget _buildDay(DateTime dateTime) {
      return Padding(
        padding: paddingDay,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderDayColor,
              width: kBorderDayWidth,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              dateTime.day.toString(),
              style:
                  dayTextStyle ?? AppTextStyle(color: kAppBlack).primaryLabel2,
            ),
          ),
        ),
      );
    }

    Widget _buildSelectedDay(DateTime dateTime) {
      return Padding(
        padding: paddingDay,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundSelectedDay,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              dateTime.day.toString(),
              style: selectedDayTextStyle ??
                  AppTextStyle(color: kAppWhite).primaryLabel2,
            ),
          ),
        ),
      );
    }

    Widget _buildCurrentDay(DateTime dateTime) {
      return Padding(
        padding: paddingDay,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderCurrentDayColor,
              width: kBorderDayWidth,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              dateTime.day.toString(),
              style: currentDayTextStyle ??
                  AppTextStyle(color: kAppBlack).primaryLabel2,
            ),
          ),
        ),
      );
    }

    Widget _buildDisableDay(DateTime dateTime) {
      return Padding(
        padding: paddingDay,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundDisabledDay,
            border: Border.all(
              color: backgroundDisabledDay,
              width: kBorderDayWidth,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              dateTime.day.toString(),
              style: disabledDayTextStyle ??
                  AppTextStyle(color: kAppGreyB).primaryLabel2,
            ),
          ),
        ),
      );
    }

    Widget _buildCTA() {
      return Padding(
        padding: EdgeInsets.only(top: kSpacer.xs, bottom: kSpacer.standard),
        child: WideButton(
          title: 'Select',
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          fullWidth: true,
          widgetTheme: WidgetTheme.blueWhite,
        ),
      );
    }

    DateTime _initialDate = initialDate;

    if (selectedDay.isAfter(initialDate)) {
      _initialDate = selectedDay;
    }

    return showRoundedDatePicker(
      context: context,
      initialDate: _initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      borderRadius: borderCalendar,
      height: AppQuery(context).isSmallDevice
          ? kCalendarSmallHeight
          : kCalendarHeight,
      dialogPadding: EdgeInsets.only(
        left: AppSpacer(context: context).standard,
        right: AppSpacer(context: context).standard,
        bottom: AppQuery(context).kDefaultBottomMargin,
      ),
      barrierDismissible: barrierDismissible,
      listDateDisabled: listDateDisabled,
      disabledIconColor: kAppGreyD,
      leftIcon: Icons.keyboard_arrow_left,
      rightIcon: Icons.keyboard_arrow_right,
      selectableDayPredicate: (DateTime date) {
        return date.day == initialDate.day || date.isAfter(initialDate);
      },
      styleDatePicker: datePickerStyle,
      customWeekDays: customWeekDays ??
          <String>['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'],
      builderDay: (
        DateTime dateTime,
        bool isCurrentDay,
        bool isDisable,
        bool isSelected,
        TextStyle defaultTextStyle,
      ) {
        if (isSelected) {
          return _buildSelectedDay(dateTime);
        }

        if (isCurrentDay) {
          return _buildCurrentDay(dateTime);
        }

        if (isDisable) {
          return _buildDisableDay(dateTime);
        }

        return _buildDay(dateTime);
      },
      builderActions: builderActions ?? _buildCTA(),
      onTapDay: (DateTime dateTime, bool available) {
        if (available && onPressDay != null) {
          onPressDay(dateTime);
        }
        return available;
      },
      barrierColor: kAppBlack.withOpacity(0.5),
      transitionDuration: kDuration500,
      transitionBuilder: (_, Animation<double> anim, __, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: kStartOffsetY,
            end: kEndOffsetY,
          ).animate(
            CurvedAnimation(
              parent: anim,
              curve: kZestEaseOut,
              reverseCurve: kZestEaseIn,
            ),
          ),
          child: child,
        );
      },
    );
  }

  static int _daysInMonth(DateTime date) {
    final DateTime firstDayThisMonth =
        DateTime(date.year, date.month, date.day);
    final DateTime firstDayNextMonth = DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }
}
