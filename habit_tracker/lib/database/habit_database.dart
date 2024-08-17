import 'package:flutter/material.dart';
import 'package:habit_tracker/models/app_settings.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  // INITIALIZE DATABASE
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  // list of habits
  final List<Habit> currentHabits = [];

  // CREATE - Add a new habit
  Future<void> addHabit(String habitName) async {
    // create a new habit
    final newHabit = Habit()..name = habitName;

    // save to db
    await isar.writeTxn(() => isar.habits.put(newHabit));

    // re-read from db
    await readHabits();
  }

  // READ saved habits from db
  Future<void> readHabits() async {
    // fetch all habits from db
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    // give to current habits
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    // update UI
    notifyListeners();
  }

  // UPDATE - Check habit on and off
  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    final habit = await isar.habits.get(id);

    // update completion status
    if (habit != null) {
      await isar.writeTxn(() async {
        final today = DateTime.now();

        if (isCompleted) {
          // add the current date if it is not already in the list
          habit.completedDays.add(DateTime(today.year, today.month, today.day));
        } else {
          // remove the current date if habit is marked not completed
          habit.completedDays.removeWhere((date) =>
            date.year == today.year &&
            date.month == today.month &&
            date.day == today.day,
          );
        }

        // save the updated habits back to the db
        await isar.habits.put(habit);
      });
    }

    // re-read from db
    await readHabits();
  }

  // UPDATE - Edit habit name
  Future<void> updateHabitName(int id, String newName) async {
    final habit = await isar.habits.get(id);

    if (habit != null) {
      await isar.writeTxn(() async {
        habit.name = newName;
        await isar.habits.put(habit);
      });
    }

    // re-read from db
    await readHabits();
  }

  // DELETE - delete habit
  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });

    // re-read from db
    await readHabits();
  }

  saveFirstLaunchDate() {}

  void deleteHabitName(Id id) {}
}
