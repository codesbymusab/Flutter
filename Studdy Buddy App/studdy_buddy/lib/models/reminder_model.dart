const String tableReminders = 'reminders';

class ReminderFields {
  static String id = '_id';
  static String message = 'message';
  static String scheduledTime = 'time';
  static String isRecurring = 'isrecurring';
}

class Reminder {
  String id;
  String message;
  DateTime scheduledTime;
  int isRecurring;

  Reminder({
    required this.id,
    required this.message,
    required this.scheduledTime,
    required this.isRecurring,
  });

  Map<String, Object> toJson() => <String, Object>{
    ReminderFields.id: id,
    ReminderFields.message: message,
    ReminderFields.scheduledTime: scheduledTime.toIso8601String(),
    ReminderFields.isRecurring: isRecurring,
  };

  factory Reminder.fromJson(Map<String, Object?> map) => Reminder(
    id: map[ReminderFields.id] as String,
    message: map[ReminderFields.message] as String,
    scheduledTime: DateTime.parse(map[ReminderFields.scheduledTime] as String),
    isRecurring: map[ReminderFields.isRecurring] as int,
  );
}
