import 'package:flutter/material.dart';
import 'package:application_belajar/models/task_model.dart';
import 'package:application_belajar/models/user_model.dart';
import 'package:uuid/uuid.dart';

class AppProvider extends ChangeNotifier {
  late User _user;
  List<Task> _tasks = [];
  List<Task> _dailyPuzzleTasks = [];
  int _completedTasksToday = 0;

  User get user => _user;
  List<Task> get tasks => _tasks;
  List<Task> get dailyPuzzleTasks => _dailyPuzzleTasks;
  int get completedTasksToday => _completedTasksToday;
  int get puzzleProgress => _dailyPuzzleTasks.isEmpty 
      ? 0 
      : (_dailyPuzzleTasks.where((t) => t.isCompleted).length / _dailyPuzzleTasks.length * 100).toInt();

  AppProvider() {
    _initializeUser();
  }

  void _initializeUser() {
    _user = User(
      id: const Uuid().v4(),
      name: 'An Yujin',
      email: 'user@example.com',
      lastActiveDate: DateTime.now(),
    );
  }

  void updateUser(User user) {
    _user = user;
    notifyListeners();
  }

  void addTask(String title, String? description, DateTime deadline) {
    final task = Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
      deadline: deadline,
      createdAt: DateTime.now(),
    );
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    _dailyPuzzleTasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  void addToDailyPuzzle(Task task) {
    if (_dailyPuzzleTasks.length < 6 && !_dailyPuzzleTasks.any((t) => t.id == task.id)) {
      _dailyPuzzleTasks.add(task);
      notifyListeners();
    }
  }

  void updateTask(String taskId, String title, String? description) {
    // Update in _tasks
    final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      _tasks[taskIndex] = _tasks[taskIndex].copyWith(title: title, description: description);
    }
    // Update in _dailyPuzzleTasks
    final dailyTaskIndex = _dailyPuzzleTasks.indexWhere((task) => task.id == taskId);
    if (dailyTaskIndex != -1) {
      _dailyPuzzleTasks[dailyTaskIndex] = _dailyPuzzleTasks[dailyTaskIndex].copyWith(title: title, description: description);
    }
    notifyListeners();
  }

  void removeFromDailyPuzzle(String taskId) {
    _dailyPuzzleTasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  void completeTask(String taskId) {
    final taskIndex = _dailyPuzzleTasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      final completedTask = _dailyPuzzleTasks[taskIndex];
      _dailyPuzzleTasks[taskIndex] = completedTask.copyWith(isCompleted: true);
      
      // Add coins and update earned
      _user = _user.copyWith(
        coins: _user.coins + completedTask.coinReward,
        earnedCoins: _user.earnedCoins + completedTask.coinReward,
      );
      _completedTasksToday++;

      // Check if all tasks completed
      if (puzzleProgress == 100) {
        _user = _user.copyWith(
          streak: _user.streak + 1,
          coins: _user.coins + 50, // Bonus coins
          earnedCoins: _user.earnedCoins + 50,
          totalTasksCompleted: _user.totalTasksCompleted + _dailyPuzzleTasks.length,
        );
      }

      notifyListeners();
    }
  }

  void resetDailyPuzzle() {
    _dailyPuzzleTasks.clear();
    _completedTasksToday = 0;
    notifyListeners();
  }

  void spendCoins(int amount) {
    if (_user.coins >= amount) {
      _user = _user.copyWith(
        coins: _user.coins - amount,
        spentCoins: _user.spentCoins + amount,
      );
      notifyListeners();
    }
  }

  void addCoins(int amount) {
    _user = _user.copyWith(
      coins: _user.coins + amount,
      earnedCoins: _user.earnedCoins + amount,
    );
    notifyListeners();
  }

  List<Task> getTodaysTasks() {
    final today = DateTime.now();
    return _tasks.where((task) {
      return task.deadline.year == today.year &&
          task.deadline.month == today.month &&
          task.deadline.day == today.day;
    }).toList();
  }
}
