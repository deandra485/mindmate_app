import 'package:flutter/material.dart';
import 'package:application_belajar/models/task_model.dart';
import 'package:application_belajar/models/user_model.dart';
import 'package:application_belajar/models/puzzle_model.dart';
import 'package:uuid/uuid.dart';

class AppProvider extends ChangeNotifier {
  late User _user;
  List<Task> _tasks = [];
  List<Task> _dailyPuzzleTasks = [];
  int _completedTasksToday = 0;

  // Track the last date the streak was incremented
  DateTime? _lastStreakDate;

  // ── Weekly History for Bar Chart ──
  // Key: 'yyyy-MM-dd', Value: { 'tasks': int, 'coins': int }
  final Map<String, Map<String, int>> _weeklyHistory = {};

  // ── Coin History State ──
  final List<Map<String, dynamic>> _coinHistory = [];

  User get user => _user;
  List<Task> get tasks => _tasks;
  List<Task> get dailyPuzzleTasks => _dailyPuzzleTasks;
  int get completedTasksToday => _completedTasksToday;
  int get puzzleProgress => _dailyPuzzleTasks.isEmpty 
      ? 0 
      : (_dailyPuzzleTasks.where((t) => t.isCompleted).length / _dailyPuzzleTasks.length * 100).toInt();

  List<Map<String, dynamic>> get coinHistory => List.unmodifiable(_coinHistory);

  /// Returns the last 7 days of history for bar chart.
  /// Each entry: { 'day': 'Mon', 'date': '2026-05-25', 'tasks': 3, 'coins': 15 }
  List<Map<String, dynamic>> get weeklyBarData {
    final now = DateTime.now();
    final days = <Map<String, dynamic>>[];
    const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final key = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      final record = _weeklyHistory[key];
      days.add({
        'day': dayNames[date.weekday - 1],
        'tasks': record?['tasks'] ?? 0,
        'coins': record?['coins'] ?? 0,
      });
    }
    return days;
  }

  /// Puzzle is unlocked if the user's streak >= puzzle index + 1.
  /// e.g. streak 1 = puzzle_1 unlocked, streak 3 = puzzle_1, 2, 3 unlocked.
  bool isPuzzleUnlocked(String id) {
    final index = allPuzzles.indexWhere((p) => p.id == id);
    if (index < 0) return false;
    return _user.streak >= (index + 1);
  }

  void _logCoinTransaction(String type, String title, int amount) {
    _coinHistory.insert(0, {
      'type': type,
      'title': title,
      'date': DateTime.now().toIso8601String(),
      'amount': amount,
    });
  }

  bool unlockPuzzle(String id, int cost) {
    if (_user.coins >= cost && !isPuzzleUnlocked(id)) {
      _user = _user.copyWith(
        coins: _user.coins - cost,
        spentCoins: _user.spentCoins + cost,
      );
      
      final puzzle = allPuzzles.firstWhere((p) => p.id == id, orElse: () => allPuzzles.first);
      _logCoinTransaction('exchange', 'Unlocked ${puzzle.title}', -cost);
      
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Master list of all collectible puzzles.
  static const List<Puzzle> allPuzzles = [
    Puzzle(
      id: 'puzzle_1',
      title: 'Winter Cabin',
      description: 'A cozy house blanketed in pristine white snow.',
      assetPath: 'assets/images/puzzle_1.png',
      coinCost: 50,
    ),
    Puzzle(
      id: 'puzzle_2',
      title: 'Lakeside Modern',
      description: 'A sleek modern house resting by a tranquil lake.',
      assetPath: 'assets/images/puzzle_2.png',
      coinCost: 75,
    ),
    Puzzle(
      id: 'puzzle_3',
      title: 'Misty Pine Forest',
      description: 'Tall pines silhouetted in a soft lavender mist.',
      assetPath: 'assets/images/puzzle_3.png',
      coinCost: 100,
    ),
    Puzzle(
      id: 'puzzle_4',
      title: 'Purple Peaks',
      description: 'Majestic mountains rising above the purple clouds.',
      assetPath: 'assets/images/puzzle_4.png',
      coinCost: 100,
    ),
    Puzzle(
      id: 'puzzle_5',
      title: 'Ice River Valley',
      description: 'A winding frozen river through a snowy mountain pass.',
      assetPath: 'assets/images/puzzle_5.png',
      coinCost: 120,
    ),
    Puzzle(
      id: 'puzzle_6',
      title: 'Spring Meadow',
      description: 'Green hills and a winding path in a beautiful valley.',
      assetPath: 'assets/images/puzzle_6.png',
      coinCost: 150,
    ),
    Puzzle(
      id: 'puzzle_7',
      title: 'Balloon Festival',
      description: 'Colorful hot-air balloons floating through a pink sky.',
      assetPath: 'assets/images/puzzle_7.png',
      coinCost: 200,
    ),
  ];

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
      
      // Track in weekly history
      final now = DateTime.now();
      final dayKey = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      _weeklyHistory.putIfAbsent(dayKey, () => {'tasks': 0, 'coins': 0});
      _weeklyHistory[dayKey]!['tasks'] = (_weeklyHistory[dayKey]!['tasks'] ?? 0) + 1;
      _weeklyHistory[dayKey]!['coins'] = (_weeklyHistory[dayKey]!['coins'] ?? 0) + completedTask.coinReward;

      _logCoinTransaction('task', 'Completed 1 task', completedTask.coinReward);

      // Check if 6 tasks completed today → streak +1 (once per day)
      if (_completedTasksToday == 6) {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);
        final isNewDay = _lastStreakDate == null ||
            DateTime(_lastStreakDate!.year, _lastStreakDate!.month, _lastStreakDate!.day)
                .isBefore(today);

        _user = _user.copyWith(
          streak: isNewDay ? _user.streak + 1 : _user.streak,
          coins: _user.coins + 50, // Bonus coins
          earnedCoins: _user.earnedCoins + 50,
          totalTasksCompleted: _user.totalTasksCompleted + 6,
        );

        if (isNewDay) {
          _lastStreakDate = now;
        }
        _logCoinTransaction('bonus', '6 tasks completed today', 50);
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
      _logCoinTransaction('exchange', 'Coin Exchange', -amount);
      notifyListeners();
    }
  }

  void addCoins(int amount) {
    _user = _user.copyWith(
      coins: _user.coins + amount,
      earnedCoins: _user.earnedCoins + amount,
    );
    _logCoinTransaction('reward', 'Reward', amount);
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
