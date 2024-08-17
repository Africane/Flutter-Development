import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_drawer.dart';
import 'package:habit_tracker/components/my_habit_tile.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/util/habit_util.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // read existing habits on app startup
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
    super.initState();
  }

  // text controller
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  // create new habit
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textEditingController,
          decoration: const InputDecoration(
            hintText: "Create a new habit",
          ),
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: () {
              // get the new habit name
              String newHabitName = textEditingController.text.trim();

              if (newHabitName.isNotEmpty) {
                // save to db
                context.read<HabitDatabase>().addHabit(newHabitName);

                // pop box
                Navigator.pop(context);

                // clear controller
                textEditingController.clear();
              }
            },
            child: const Text('Save'),
          ),

          // cancel button
          MaterialButton(
            onPressed: () {
              // pop box
              Navigator.pop(context);

              // clear controller
              textEditingController.clear();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // check habit on and off
  void checkHabitOnOff(bool? value, Habit habit) {
    // update habit completion status
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
      ),
      body: _buildHabitList(),
    );
  }

  // build habit list
  Widget _buildHabitList() {
    // habit db
    final habitDatabase = context.watch<HabitDatabase>();

    // current habits
    List<Habit> currentHabits = habitDatabase.currentHabits;

    // return list of habits UI
    return ListView.builder(
      itemCount: currentHabits.length,
      itemBuilder: (context, index) {
        // get each individual habit
        final habit = currentHabits[index];

        // check if the habit is completed today
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

        // return habit tile UI
        return MyHabitTile(
          text: habit.name, 
          isCompleted: isCompletedToday, 
          onChanged: (value) => checkHabitOnOff(value, habit),
        );
      },
    );
  }
}
