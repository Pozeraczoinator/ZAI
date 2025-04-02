import 'package:flutter/material.dart';
import 'package:sport_plus/config/app_colors.dart';
import 'package:sport_plus/config/app_typography.dart';
import 'package:sport_plus/screens/trainings/models/calendar_training.dart';
import 'package:table_calendar/table_calendar.dart';

class TrainingsCalendar extends StatelessWidget {
  final Map<DateTime, List<CalendarTraining>> trainings;
  final DateTime selectedDay;
  final DateTime focusedDay;
  final void Function(DateTime) onChanged;
  final void Function(DateTime) onMonthChanged;
  const TrainingsCalendar(
      {super.key,
      required this.trainings,
      required this.focusedDay,
      required this.selectedDay,
      required this.onChanged,
      required this.onMonthChanged});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      eventLoader: (day) {
        for (var element in trainings.entries) {
          if (isSameDay(element.key, day)) {
            return element.value;
          }
        }
        return [];
      },
      headerStyle:
          const HeaderStyle(titleCentered: true, formatButtonVisible: false),
      calendarStyle: CalendarStyle(
          todayDecoration: const BoxDecoration(
            color: AppColors.mainColor,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: AppColors.mainColor,
            ),
          ),
          selectedTextStyle: AppTypography.defaultTextStyle),
      locale: 'pl_PL',
      firstDay: DateTime(2010),
      lastDay: DateTime(2040),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: (newSelectedDay, newFocusedDay) =>
          onChanged(newSelectedDay),
      onPageChanged: (focusedDay) => onMonthChanged(focusedDay),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, events) {
          if (events.isNotEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...events.map((event) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    width: 8,
                    height: 8,
                  );
                })
              ],
            );
          }
          return null;
        },
      ),
    );
  }
}
