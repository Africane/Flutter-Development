import 'package:flutter/material.dart';
import 'package:habit_tracker/models/app_settings.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;
  
  String? get newName => null;
  
  Id? get id => null;

  /* SETUP */
  // INITIALIZE DATABASE
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  // SAVE FIRST DATE OF THE APP START UP (FOR HEATMAP)
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  // GET FIRST DATE OF APP START UP (FOR HEATMAP)
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  // C R U D _ _ _ O P E R A T I O N S
  // list of habits
  final List<Habit> currentHabits = [];

  // CREATE - Add a new habit
  Future<void> addHabit(String HabitName) async {
    // create a new habit
    final newHabit = Habit()..name = HabitName;

    // save to db
    await isar.writeTxn(() => isar.habits.put(newHabit));

    // re-read from db
    readHabits();
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
        // if habit is completed, add the current day to the completedDays list
        if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
          // today
          final today = DateTime.now();

          // add the current date if it is not already in the list
          habit.completedDays.add(
            DateTime(
              today.year,
              today.month,
              today.day,
            )
          );
        }

        // if habit is not completed, remove the current date from the list
        else {
          // remove the current date if habit is marked not completed
          habit.completedDays.removeWhere(
            (date) => 
            date.year == DateTime.now().year &&
            date.month == DateTime.now().month &&
            date.day == DateTime.now().day,
          );
        }

        // save the updated habits back to the db
        await isar.habits.put(habit);
      });
    }

    // re-read from db
    readHabits();
  }

  // UPDATE - Edit habit name
  Future<void> updateHabitName() async {
    // find the specific habit
    final habit = await isar.habits.get(id!);

    // update habit name
    if (habit != null) {
      // update name
      await isar.writeTxn(() async {
        habit.name = newName!;
        // save updated habit back to db
        await isar.habits.put(habit);
      });
    }

    // re-read from db
    readHabits();

    // DELETE - delete habit
    Future<void> deleteHabit(int id) async {
      // perform the delete
      await isar.writeTxn(() async {
        await isar.habits.delete(id);
      });
    }

  // re-read from db
  readHabits();

  }

}