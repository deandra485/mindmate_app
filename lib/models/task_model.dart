class Task {
  final String id;
  final String title;
  final String? description;
  final DateTime deadline;
  final bool isCompleted;
  final DateTime createdAt;
  final int coinReward;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.deadline,
    this.isCompleted = false,
    required this.createdAt,
    this.coinReward = 10,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? deadline,
    bool? isCompleted,
    DateTime? createdAt,
    int? coinReward,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      coinReward: coinReward ?? this.coinReward,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline.toIso8601String(),
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'coinReward': coinReward,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'],
      deadline: DateTime.parse(map['deadline'] ?? DateTime.now().toIso8601String()),
      isCompleted: map['isCompleted'] ?? false,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      coinReward: map['coinReward'] ?? 10,
    );
  }
}
