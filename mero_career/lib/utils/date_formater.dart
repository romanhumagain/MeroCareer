import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

String formatDeadline(String deadline) {
  try {
    // Parse the deadline string to a DateTime object
    DateTime deadlineDateTime = DateTime.parse(deadline);

    // Get the current time
    DateTime now = DateTime.now();

    // Calculate the difference
    Duration difference = deadlineDateTime.difference(now);

    // Determine if the deadline is in the past or future
    bool isPast = difference.isNegative;

    // Calculate absolute time difference for consistent formatting
    int minutes = difference.abs().inMinutes;
    int hours = difference.abs().inHours;
    int days = difference.abs().inDays;

    // Format based on time range
    if (minutes < 60) {
      return isPast
          ? "Deadline passed $minutes minute${minutes > 1 ? 's' : ''} ago"
          : "Deadline $minutes minute${minutes > 1 ? 's' : ''} from now";
    } else if (hours < 24) {
      return isPast
          ? "Deadline passed $hours hour${hours > 1 ? 's' : ''} ago"
          : "Deadline $hours hour${hours > 1 ? 's' : ''} from now";
    } else {
      return isPast
          ? "Deadline passed $days day${days > 1 ? 's' : ''} ago"
          : "Deadline $days day${days > 1 ? 's' : ''} from now";
    }
  } catch (e) {
    return "Invalid deadline format";
  }
}

String formatPostedDate(String dateString) {
  // Parse the date string into a DateTime object
  DateTime date = DateTime.parse(dateString);

  // Get the day, month, and year
  final day = DateFormat.d().format(date);
  final month = DateFormat.MMM().format(date);
  final year = DateFormat.y().format(date);

  // Determine the suffix based on the day
  String suffix = 'th';
  if (day == '1' || day == '21' || day == '31') {
    suffix = 'st';
  } else if (day == '2' || day == '22') {
    suffix = 'nd';
  } else if (day == '3' || day == '23') {
    suffix = 'rd';
  }

  // Return the formatted string
  return '$day$suffix $month, $year';
}

String formatEduDate(String dateString) {
  DateTime date = DateTime.parse(dateString);

  String formattedDate = DateFormat("MMM, yyyy").format(date);

  return formattedDate;
}

String formatSavedAt(String savedAt) {
  try {
    // Parse the `saved_at` string into a DateTime object
    DateTime savedAtDate = DateTime.parse(savedAt);
    DateTime now = DateTime.now();

    // Calculate the difference in time
    Duration difference = now.difference(savedAtDate);

    if (difference.inSeconds < 60) {
      return "${difference.inSeconds} seconds ago";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else if (difference.inDays == 1) {
      return "Yesterday";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else {
      // Format as "MMM dd, yyyy" for older dates
      return DateFormat('MMM dd, yyyy').format(savedAtDate);
    }
  } catch (e) {
    return "Invalid date"; // Handle parsing errors gracefully
  }
}
